#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#define PORT 8080
#define LOCATION "/tmp/www"

void *handle_client(void *arg);

int main() {
    int server_fd, new_socket;
    struct sockaddr_in address;
    // int addrlen = sizeof(address);

    server_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (server_fd == 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }

    printf("Socket criado com sucesso\n\n");
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(PORT);

    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }

    printf("Bind realizado com sucesso\n\n");

    if (listen(server_fd, 5) < 0) {
        perror("listen failed");
        exit(EXIT_FAILURE);
    }

    // Descobre e mostra o IP local que está rodando
    char hostbuffer[256];
    char *IPbuffer;
    struct hostent *host_entry;
    int hostname;

    hostname = gethostname(hostbuffer, sizeof(hostbuffer));
    if (hostname == -1) {
        perror("gethostname");
    } else {
        host_entry = gethostbyname(hostbuffer);
        if (host_entry == NULL) {
            perror("gethostbyname");
        } else {
            IPbuffer = inet_ntoa(*((struct in_addr*)host_entry->h_addr_list[0]));
            printf("Acesse no navegador: http://%s:%d/\n\n", IPbuffer, PORT);
        }
    }

    printf("Servidor rodando na porta %d...\n\n", PORT);

    while (1) {
        struct sockaddr_in client_addr;
        socklen_t client_len = sizeof(client_addr);

        new_socket = accept(server_fd, (struct sockaddr *)&client_addr, &client_len);
        if (new_socket < 0) {
            perror("accept failed");
            printf("Falha ao aceitar conexao\n");
            continue;
        }

        char client_ip[INET_ADDRSTRLEN];
        inet_ntop(AF_INET, &(client_addr.sin_addr), client_ip, INET_ADDRSTRLEN);
        printf("Nova conexão aceita de %s:%d\n", client_ip, ntohs(client_addr.sin_port));

        pthread_t tid;
        int *pclient = malloc(sizeof(int));
        *pclient = new_socket;
        pthread_create(&tid, NULL, handle_client, pclient);
        pthread_detach(tid);
    }

    close(server_fd);
    return 0;
}

const char* get_mime_type(const char *filename) {
    const char *ext = strrchr(filename, '.');
    if (!ext) return "application/octet-stream"; 
    ext++;

    if (strcmp(ext, "html") == 0 || strcmp(ext, "htm") == 0) 
        return "text/html";
    if (strcmp(ext, "css") == 0)  
        return "text/css";
    if (strcmp(ext, "js") == 0)   
        return "application/javascript";
    if (strcmp(ext, "json") == 0) 
        return "application/json";
    if (strcmp(ext, "png") == 0)  
        return "image/png";
    if (strcmp(ext, "jpg") == 0 || strcmp(ext, "jpeg") == 0) 
        return "image/jpeg";
    if (strcmp(ext, "gif") == 0)  
        return "image/gif";
    if (strcmp(ext, "svg") == 0)  
        return "image/svg+xml";
    if (strcmp(ext, "ico") == 0)  
        return "image/x-icon";
    if (strcmp(ext, "txt") == 0)  
        return "text/plain";
    if (strcmp(ext, "pdf") == 0)  
        return "application/pdf";

    return "application/octet-stream";
}

void send_file(int client_socket, const char *filepath, const char *status) {
    FILE *fp = fopen(filepath, "r");
    if (!fp) {
        // fallback simples
        char response[512];
        snprintf(response, sizeof(response),
                 "HTTP/1.1 %s\r\n"
                 "Content-Type: text/html\r\n\r\n"
                 "<h1>%s</h1>", status, status);
        send(client_socket, response, strlen(response), 0);
        printf("[%s] Arquivo não encontrado: %s\n", status, filepath);
        return;
    }

    const char *mime = get_mime_type(filepath);

    char header[256];
    snprintf(header, sizeof(header),
             "HTTP/1.1 %s\r\n"
             "Content-Type: %s\r\n\r\n", status, mime);
    send(client_socket, header, strlen(header), 0);

    char buffer[1024];
    size_t bytes;
    while ((bytes = fread(buffer, 1, sizeof(buffer), fp)) > 0) {
        send(client_socket, buffer, bytes, 0);
    }
    fclose(fp);

    printf("[%s] Arquivo enviado: %s (%s)\n", status, filepath, mime);
}

void send_404(int client_socket) {
    send_file(client_socket, LOCATION "/erro404.html", "404 Not Found");
}

void send_501(int client_socket) {
    send_file(client_socket, LOCATION "/erro501.html", "501 Not Implemented");
}

void *handle_client(void *arg) {
    int client_socket = *((int *)arg);
    free(arg);

    char buffer[2048];

    int bytes_read = recv(client_socket, buffer, sizeof(buffer) - 1, 0);
    if (bytes_read <= 0) {
        close(client_socket);
        return NULL;
    }
    buffer[bytes_read] = '\0';

    char method[8], path[1024];
    sscanf(buffer, "%s %s", method, path);

    printf("Requisição recebida: %s %s\n", method, path);

    if (strcmp(method, "GET") != 0) {
        printf("[501] Método não implementado: %s\n", method);
        send_501(client_socket);
        close(client_socket);
        return NULL;
    }

    if (strcmp(path, "/") == 0) {
        strcpy(path, "/index.html");
    }

    char filepath[2048];
    snprintf(filepath, sizeof(filepath), "%s%s", LOCATION, path);

    send_file(client_socket, filepath, "200 OK");

    close(client_socket);
    return NULL;
}

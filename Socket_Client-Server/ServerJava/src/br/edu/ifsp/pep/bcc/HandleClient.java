package br.edu.ifsp.pep.bcc;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.nio.charset.StandardCharsets;

public class HandleClient implements Runnable {
    private final Socket socket;
    private final Server server;

    public HandleClient(Socket socket, Server server) {
        this.socket = socket;
        this.server = server;
    }

    @Override
    public void run() {
        String clientInfo = socket.getRemoteSocketAddress().toString();
        System.out.printf("\n[INFO] Cliente conectado: %s%n", clientInfo);

        try (BufferedReader r = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8));
             BufferedWriter w = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), StandardCharsets.UTF_8))) {

            String line;
            while ((line = r.readLine()) != null) {
                System.out.printf("[REQ] De %s: \"%s\"%n", clientInfo, line);

                String resp = handle(line);

                w.write(resp);
                w.write("\r\n");
                w.flush();

                System.out.printf("[RES] Para %s: \"%s\"%n", clientInfo, resp);

                if (resp.startsWith("221 ")) {
                    System.out.printf("[INFO] Cliente %s pediu QUIT. Encerrando...%n", clientInfo);
                    break;
                }
            }
        } catch (SocketTimeoutException e) {
            System.out.printf("[TIMEOUT] Cliente %s ficou inativo. Encerrando.%n", clientInfo);
        } catch (Exception e) {
            System.out.printf("[ERRO] Problema com cliente %s: %s%n", clientInfo, e.getMessage());
        } finally {
            server.onClientClosed(socket);
            System.out.printf("[INFO] Conexão encerrada com %s%n", clientInfo);
        }
    }

    private String handle(String line) {
        try {
            if (line == null) return "500 ERROR";
            line = line.trim();

            if (line.equalsIgnoreCase("PING")) return "204 PONG";
            if (line.equalsIgnoreCase("QUIT")) return "221 BYE";

            String[] parts = line.split("\\s+");
            if (parts.length == 3 && parts[0].equalsIgnoreCase("REQ")) {
                String type = parts[1].toUpperCase();
                String numRaw = parts[2];
                String digits = numRaw.replaceAll("\\D", "");

                switch (type) {
                    case "CPF":
                        if (digits.length() != 11) return "422 MALFORMED";
                        boolean cpfOk = Validators.isValidCPF(digits);
                        return (cpfOk ? "200 VALID CPF " : "400 INVALID CPF ") + digits;
                    case "CNPJ":
                        if (digits.length() != 14) return "422 MALFORMED";
                        boolean cnpjOk = Validators.isValidCNPJ(digits);
                        return (cnpjOk ? "200 VALID CNPJ " : "400 INVALID CNPJ ") + digits;
                    default:
                        return "422 MALFORMED REQ";
                }
            }
            return "422 MALFORMED REQ";
        } catch (Exception e) {
            return "500 ERROR";
        }
    }
}

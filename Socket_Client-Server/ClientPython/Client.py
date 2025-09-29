import socket

class Client:
    def __init__(self):
        self.host = "localhost"
        self.port = 8080
        self.line = b""

    def format_cmd(self, s):
        s = s.replace(".", "")
        s = s.replace("-", "")
        s = s.replace("/", "")
        return s

    def send_message(self):
        try:
            print(f"\nTentando conectar com {self.host}:{self.port} ...")
            with socket.create_connection((self.host, self.port), timeout=10) as sock:
                f = sock.makefile("rwb", buffering=0)
                print(f"Conexão bem sucedida. \n")
                f.write(self.line)
                print("-->", self.line.decode("utf-8"))
                resp = f.readline().decode("utf-8", errors="ignore").strip()
                print("<--", resp, "\n")
        except:
            print("Conexão falhou. Servidor está offline. ")

    def run(self):
        run = True

        while run:
            cmd = input("Escreva o comando (<num> | PING | QUIT): ").strip()

            if not cmd:
                continue

            if cmd.upper() == "PING":
                self.line = b"PING\r\n"
            elif cmd.upper() == "QUIT":
                self.line = b"QUIT\r\n"
                run = False
            else:
                cmd = self.format_cmd(cmd)
                if cmd.isdigit():
                    if len(cmd) == 14:
                        typ = "CNPJ"
                    elif len(cmd) == 11:
                        typ = "CPF"
                    else:
                        print("Formato de CPF/CNPJ inválido. ")
                        continue
                    self.line = f"REQ {typ} {cmd}\r\n".encode("utf-8")
                else:
                    print("Entrada Inválida. Tente: 52998224725 | 11444777000161 | PING | QUIT")
                    continue

            self.send_message()

if __name__ == "__main__":
    c = Client()
    c.run()
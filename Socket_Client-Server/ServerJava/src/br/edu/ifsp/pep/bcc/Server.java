package br.edu.ifsp.pep.bcc;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;

public class Server {
    private final int port;
    private final int maxConnections;
    private final List<Socket> activeSockets = Collections.synchronizedList(new ArrayList<>());
    private final ExecutorService pool;
    private final AtomicInteger activeCount = new AtomicInteger(0);

    public static void main(String[] args) throws Exception {
        int port = 8080;
        int maxConn = 5;
        int poolSize = 16;
        if (args.length >= 1) port = Integer.parseInt(args[0]);
        if (args.length >= 2) maxConn = Integer.parseInt(args[1]);
        if (args.length >= 3) poolSize = Integer.parseInt(args[2]);

        new Server(port, maxConn, poolSize).start();
    }

    public Server(int port, int maxConnections, int poolSize) {
        this.port = port;
        this.maxConnections = maxConnections;
        this.pool = Executors.newFixedThreadPool(poolSize);
    }

    public void start() throws IOException {
        try (ServerSocket server = new ServerSocket(port)) {
            System.out.printf("[INFO] Servidor escutando na porta %d (MAX_CONN=%d)%n", port, maxConnections);

            while (true) {
                Socket s = server.accept();
                s.setSoTimeout(60_000); // tempo sem usar

                int current = activeCount.get();
                if (current >= maxConnections) {
                    System.out.printf("[WARN] Conexão recusada de %s: limite de conexões atingido%n", s.getRemoteSocketAddress());
                    try (BufferedWriter w = new BufferedWriter(new OutputStreamWriter(s.getOutputStream(), "UTF-8"))) {
                        w.write("429 BUSY\r\n");
                        w.flush();
                    } catch (Exception ignore) {}
                    s.close();
                    continue;
                }

                activeSockets.add(s);
                activeCount.incrementAndGet();
                pool.submit(new HandleClient(s, this));
            }
        }
    }

    protected void onClientClosed(Socket s) {
        activeSockets.remove(s);
        activeCount.decrementAndGet();
        try { s.close(); } catch (IOException ignored) {}
    }
}

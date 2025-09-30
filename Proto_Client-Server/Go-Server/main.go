package main

import (
	"context"
	"log"
	"net"

	"google.golang.org/grpc"

	// importa o proto gerado
	pb "document-validator-server/proto/validator"
)

// struct pra implementar o servidor
type server struct {
	pb.UnimplementedValidatorServer
}

func (s *server) ValidateDocument(ctx context.Context, req *pb.ValidationRequest) (*pb.ValidationResponse, error) {
	log.Printf("Received document number: %v", req.GetDocumentNumber())

	isValid := req.GetDocumentNumber() != ""

	return &pb.ValidationResponse{IsValid: isValid}, nil
}

func main() {
	// coloca um listener na porta TCP
	lis, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	// cria uma instância do servidor gRPC
	s := grpc.NewServer()

	// Registra o serviço Validator no servidor gRPC
	pb.RegisterValidatorServer(s, &server{})

	log.Println("gRPC server listening at", lis.Addr())

	// inicia o servidor gRPC
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}

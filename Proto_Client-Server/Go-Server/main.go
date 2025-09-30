package main

import (
	"context"
	"log"
	"net"
	"regexp"

	"github.com/paemuri/brdoc"
	"google.golang.org/grpc"

	// importa o proto gerado
	pb "document-validator-server/proto/validator"
)

// struct pra implementar o servidor
type server struct {
	pb.UnimplementedValidatorServer
}

func (s *server) ValidateDocument(ctx context.Context, req *pb.ValidationRequest) (*pb.ValidationResponse, error) {
	doc := req.GetDocument()
	log.Printf("Received document for validation: %v", doc)

	re := regexp.MustCompile(`[^0-9]`)
	cleanedDoc := re.ReplaceAllString(doc, "")

	if len(cleanedDoc) == 11 {
		isValid := brdoc.IsCPF(cleanedDoc)
		return &pb.ValidationResponse{
			IsValid:      isValid,
			DocumentType: pb.DocumentType_CPF,
		}, nil
	}

	if len(cleanedDoc) == 14 {
		isValid := brdoc.IsCNPJ(cleanedDoc)
		return &pb.ValidationResponse{
			IsValid:      isValid,
			DocumentType: pb.DocumentType_CNPJ,
		}, nil
	}

	return &pb.ValidationResponse{
		IsValid:      false,
		DocumentType: pb.DocumentType_UNKNOWN,
	}, nil
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

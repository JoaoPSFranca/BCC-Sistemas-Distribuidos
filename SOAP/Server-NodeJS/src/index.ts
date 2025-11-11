import express from 'express';
import * as soap from 'soap';
import { readFileSync } from 'fs';
import * as path from 'path';
import { helloService } from './services/helloService';

const app = express();
const port = 3000;

const wsdlPath = path.join(__dirname, 'services/hello.wsdl');
console.log(`Tentando ler o WSDL do caminho: ${wsdlPath}`);

let xml;
try {
  xml = readFileSync(wsdlPath, 'utf8');
  console.log('Arquivo WSDL lido com sucesso.');
} catch (e) {
  console.error(`ERRO CRÍTICO: Não foi possível ler o arquivo WSDL em ${wsdlPath}`);
  console.error(e);
  process.exit(1); // Encerra o processo se não puder ler o WSDL
}

app.listen(port, () => {
  console.log(`Servidor HTTP ouvindo na porta ${port}`);

  soap.listen(app, '/hello', helloService, xml, () => {
    console.log('Servidor SOAP "HelloService" iniciado em /hello');
  });
});
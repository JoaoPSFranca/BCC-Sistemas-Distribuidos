import express from 'express';
import * as soap from 'soap';
import { myService } from './myService';
import fs from 'fs';

// Lê o arquivo WSDL
const wsdl = fs.readFileSync('echo.wsdl', 'utf8');

const app = express();
const port = 8000;

// O endpoint onde o serviço SOAP estará escutando
const endpoint = '/echo';

app.listen(port, () => {
  console.log(`[SERVIDOR] Servidor Express rodando na porta ${port}`);

  // Inicia o servidor SOAP
  soap.listen(app, endpoint, myService, wsdl, () => {
    console.log(`[SERVIDOR] Servidor SOAP iniciado em http://localhost:${port}${endpoint}?wsdl`);
  });
});

// Endpoint para facilitar o acesso ao WSDL pelo navegador
app.get(endpoint, (req, res) => {
  if (req.query.wsdl !== undefined) {
    res.set('Content-Type', 'text/xml');
    res.send(wsdl);
  } else {
    res.send('Servidor SOAP está ativo. Acesse ?wsdl para ver o contrato.');
  }
});
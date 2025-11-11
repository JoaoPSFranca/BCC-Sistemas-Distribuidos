import express from 'express';
import * as soap from 'soap';
import { readFileSync } from 'fs';
import * as path from 'path';
import { allServices } from './services';

interface IServiceToMount {
  name: string;
  path: string;
  service: any;
  xml: string;
}

export function startServer() {
  const app = express();
  const port = 3000;
  const servicesToMount: IServiceToMount[] = [];

  for (const serviceDef of allServices) {
    const wsdlPath = path.join(__dirname, 'services', serviceDef.wsdlFile);
    let xml;

    try {
      xml = readFileSync(wsdlPath, 'utf8');
      
      servicesToMount.push({
        name: serviceDef.name,
        path: serviceDef.path,
        service: serviceDef.service,
        xml: xml,
      });
    } catch (e) {
      console.error(`ERRO CRÍTICO: Não foi possível ler o arquivo WSDL em ${wsdlPath}`);
      process.exit(1);
    }
  }

  app.listen(port, () => {
    console.log(`Servidor HTTP ouvindo na porta ${port}`);

    for (const service of servicesToMount) {
      soap.listen(app, service.path, service.service, service.xml, () => {
        console.log(`Servidor SOAP "${service.name}" iniciado em ${service.path}`);
      });
    }
  });
}
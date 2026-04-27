class VeiculoConsumo {
  final String tipo; // 'Carro' | 'Moto'
  final String marca;
  final String modelo;
  final String motor;
  final String categoria;
  final double consumoCidade;
  final double consumoEstrada;

  const VeiculoConsumo({
    required this.tipo,
    required this.marca,
    required this.modelo,
    required this.motor,
    required this.categoria,
    required this.consumoCidade,
    required this.consumoEstrada,
  });
}

/// Consumo médio com gasolina (flex) em km/L.
/// Motos: valores em km/L (gasolina).
/// Fonte: INMETRO/PBE 2024-2025 e dados do fabricante.
const List<VeiculoConsumo> veiculosConsumo = [

  // ═══════════════════════════════════════════════════════════════
  //  CARROS — HATCH
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault',    modelo: 'Kwid',          motor: '1.0 Flex',       categoria: 'Hatch',      consumoCidade: 15.3, consumoEstrada: 15.7),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Mobi',          motor: '1.0 Fire Flex',  categoria: 'Hatch',      consumoCidade: 13.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Onix',          motor: '1.0 Flex',       categoria: 'Hatch',      consumoCidade: 13.3, consumoEstrada: 16.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Onix',          motor: '1.0 Turbo Flex', categoria: 'Hatch',      consumoCidade: 13.1, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot',    modelo: '208',           motor: '1.0 Flex',       categoria: 'Hatch',      consumoCidade: 13.3, consumoEstrada: 15.8),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai',    modelo: 'HB20',          motor: '1.0 Flex',       categoria: 'Hatch',      consumoCidade: 13.5, consumoEstrada: 14.6),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai',    modelo: 'HB20',          motor: '1.0 Turbo Flex', categoria: 'Hatch',      consumoCidade: 12.8, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Polo',          motor: '1.0 TSI Flex',   categoria: 'Hatch',      consumoCidade: 13.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Polo',          motor: '1.0 MPI Flex',   categoria: 'Hatch',      consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault',    modelo: 'Sandero',       motor: '1.0 Flex',       categoria: 'Hatch',      consumoCidade: 14.2, consumoEstrada: 14.1),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault',    modelo: 'Stepway',       motor: '1.0 Flex',       categoria: 'Hatch',      consumoCidade: 13.9, consumoEstrada: 14.7),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Argo',          motor: '1.0 Flex',       categoria: 'Hatch',      consumoCidade: 13.0, consumoEstrada: 14.7),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Argo',          motor: '1.3 Flex',       categoria: 'Hatch',      consumoCidade: 12.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Gol',           motor: '1.0 Flex',       categoria: 'Hatch',      consumoCidade: 13.3, consumoEstrada: 14.4),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford',       modelo: 'Ka',            motor: '1.0 Flex',       categoria: 'Hatch',      consumoCidade: 13.4, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Uno',           motor: '1.0 Fire Flex',  categoria: 'Hatch',      consumoCidade: 13.0, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Citroën',    modelo: 'C3',            motor: '1.6 Flex',       categoria: 'Hatch',      consumoCidade: 10.9, consumoEstrada: 13.2),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Yaris Hatch',   motor: '1.3 Flex',       categoria: 'Hatch',      consumoCidade: 12.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Yaris Hatch',   motor: '1.5 Flex',       categoria: 'Hatch',      consumoCidade: 11.8, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda',      modelo: 'Fit',           motor: '1.5 Flex',       categoria: 'Hatch',      consumoCidade: 12.8, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Nissan',     modelo: 'March',         motor: '1.0 Flex',       categoria: 'Hatch',      consumoCidade: 12.9, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Nivus',         motor: '1.0 TSI Flex',   categoria: 'Hatch',      consumoCidade: 12.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai',    modelo: 'Venue',         motor: '1.0 Turbo Flex', categoria: 'Hatch',      consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Pulse',         motor: '1.0 Turbo Flex', categoria: 'Hatch',      consumoCidade: 12.5, consumoEstrada: 15.0),

  // ═══════════════════════════════════════════════════════════════
  //  CARROS — SEDAN
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Onix Plus',     motor: '1.0 Flex',       categoria: 'Sedan',      consumoCidade: 13.5, consumoEstrada: 17.4),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Onix Plus',     motor: '1.0 Turbo Flex', categoria: 'Sedan',      consumoCidade: 13.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Cronos',        motor: '1.0 Turbo Flex', categoria: 'Sedan',      consumoCidade: 13.4, consumoEstrada: 15.6),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Cronos',        motor: '1.3 Flex',       categoria: 'Sedan',      consumoCidade: 12.4, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault',    modelo: 'Logan',         motor: '1.0 Flex',       categoria: 'Sedan',      consumoCidade: 14.0, consumoEstrada: 14.9),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Virtus',        motor: '1.0 TSI Flex',   categoria: 'Sedan',      consumoCidade: 13.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Virtus',        motor: '1.6 MSI Flex',   categoria: 'Sedan',      consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai',    modelo: 'HB20S',         motor: '1.0 Turbo Flex', categoria: 'Sedan',      consumoCidade: 12.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Yaris Sedan',   motor: '1.3 Flex',       categoria: 'Sedan',      consumoCidade: 12.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Corolla',       motor: '2.0 Flex',       categoria: 'Sedan',      consumoCidade: 11.4, consumoEstrada: 13.2),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Corolla',       motor: '1.8 Hybrid',     categoria: 'Sedan',      consumoCidade: 18.5, consumoEstrada: 15.7),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda',      modelo: 'Civic',         motor: '1.5 Turbo Flex', categoria: 'Sedan',      consumoCidade: 11.8, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Nissan',     modelo: 'Versa',         motor: '1.6 Flex',       categoria: 'Sedan',      consumoCidade: 11.8, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'BMW',        modelo: 'Série 3 320i',  motor: '2.0 Turbo',      categoria: 'Sedan',      consumoCidade: 9.8,  consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mercedes',   modelo: 'Classe C 180',  motor: '1.5 Turbo',      categoria: 'Sedan',      consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Audi',       modelo: 'A3 Sedan',      motor: '1.4 TSI',        categoria: 'Sedan',      consumoCidade: 11.5, consumoEstrada: 14.0),

  // ═══════════════════════════════════════════════════════════════
  //  CARROS — SUV
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Corolla Cross', motor: '1.8 Hybrid',     categoria: 'SUV',        consumoCidade: 17.7, consumoEstrada: 14.6),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'RAV4',          motor: '2.5 Hybrid',     categoria: 'SUV',        consumoCidade: 14.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda',      modelo: 'WR-V',          motor: '1.5 Flex',       categoria: 'SUV',        consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'GWM',        modelo: 'Haval H2',      motor: '1.5 Turbo Flex', categoria: 'SUV',        consumoCidade: 11.8, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda',      modelo: 'HR-V',          motor: '1.5 Turbo Flex', categoria: 'SUV',        consumoCidade: 11.8, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot',    modelo: '2008',          motor: '1.2 Turbo Flex', categoria: 'SUV',        consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Tracker',       motor: '1.0 Turbo Flex', categoria: 'SUV',        consumoCidade: 11.2, consumoEstrada: 13.6),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault',    modelo: 'Captur',        motor: '1.3 Turbo Flex', categoria: 'SUV',        consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'T-Cross',       motor: '1.0 TSI Flex',   categoria: 'SUV',        consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai',    modelo: 'Creta',         motor: '1.0 Turbo Flex', categoria: 'SUV',        consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Pulse',         motor: '1.3 Turbo Flex', categoria: 'SUV',        consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Jeep',       modelo: 'Renegade',      motor: '1.3 Turbo Flex', categoria: 'SUV',        consumoCidade: 11.0, consumoEstrada: 12.8),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault',    modelo: 'Duster',        motor: '1.3 Turbo Flex', categoria: 'SUV',        consumoCidade: 10.8, consumoEstrada: 11.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'T-Cross',       motor: '1.4 TSI Flex',   categoria: 'SUV',        consumoCidade: 10.8, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai',    modelo: 'Creta',         motor: '2.0 Flex',       categoria: 'SUV',        consumoCidade: 10.8, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Citroën',    modelo: 'C4 Cactus',     motor: '1.6 Turbo Flex', categoria: 'SUV',        consumoCidade: 10.8, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Nissan',     modelo: 'Kicks',         motor: '1.6 Flex',       categoria: 'SUV',        consumoCidade: 11.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mitsubishi', modelo: 'Eclipse Cross',  motor: '1.5 Turbo Flex', categoria: 'SUV',        consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Caoa Chery', modelo: 'Tiggo 5x',      motor: '1.5 Turbo Flex', categoria: 'SUV',        consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda',      modelo: 'CR-V',          motor: '1.5 Turbo',      categoria: 'SUV',        consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford',       modelo: 'Territory',     motor: '1.5 Turbo',      categoria: 'SUV',        consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Corolla Cross', motor: '2.0 Flex',       categoria: 'SUV',        consumoCidade: 11.3, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'GWM',        modelo: 'Haval H6',      motor: '1.5 Turbo Flex', categoria: 'SUV',        consumoCidade: 11.3, consumoEstrada: 13.8),
  VeiculoConsumo(tipo: 'Carro', marca: 'Caoa Chery', modelo: 'Tiggo 7',       motor: '1.5 Turbo Flex', categoria: 'SUV',        consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mitsubishi', modelo: 'ASX',           motor: '2.0 Flex',       categoria: 'SUV',        consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai',    modelo: 'Tucson',        motor: '1.6 Turbo Flex', categoria: 'SUV',        consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Jeep',       modelo: 'Compass',       motor: '1.3 Turbo Flex', categoria: 'SUV',        consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Jeep',       modelo: 'Compass',       motor: '2.0 Diesel',     categoria: 'SUV',        consumoCidade: 11.5, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot',    modelo: '3008',          motor: '1.6 Turbo Flex', categoria: 'SUV',        consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Equinox',       motor: '1.5 Turbo Flex', categoria: 'SUV',        consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mitsubishi', modelo: 'Outlander',     motor: '2.0 Flex',       categoria: 'SUV',        consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'RAV4',          motor: '2.0 Flex',       categoria: 'SUV',        consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Taos',          motor: '1.4 TSI Flex',   categoria: 'SUV',        consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Jeep',       modelo: 'Commander',     motor: '1.3 Turbo Flex', categoria: 'SUV',        consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault',    modelo: 'Koleos',        motor: '2.5',            categoria: 'SUV',        consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Caoa Chery', modelo: 'Tiggo 8',       motor: '1.6 Turbo Flex', categoria: 'SUV',        consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mercedes',   modelo: 'GLA 200',       motor: '1.3 Turbo',      categoria: 'SUV',        consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'BMW',        modelo: 'X1',            motor: '2.0 Turbo',      categoria: 'SUV',        consumoCidade: 9.8,  consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'BMW',        modelo: 'X3',            motor: '2.0 Turbo',      categoria: 'SUV',        consumoCidade: 9.0,  consumoEstrada: 11.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Audi',       modelo: 'Q3',            motor: '1.4 TSI',        categoria: 'SUV',        consumoCidade: 10.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volvo',      modelo: 'XC40',          motor: '2.0 Turbo',      categoria: 'SUV',        consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Land Rover', modelo: 'Discovery Sport', motor: '2.0 Turbo',    categoria: 'SUV',        consumoCidade: 9.5,  consumoEstrada: 12.0),

  // ═══════════════════════════════════════════════════════════════
  //  CARROS — PICAPE
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Montana',       motor: '1.2 Turbo Flex', categoria: 'Picape',      consumoCidade: 12.5, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault',    modelo: 'Oroch',         motor: '1.3 Turbo Flex', categoria: 'Picape',      consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Strada',        motor: '1.3 Flex',       categoria: 'Picape',      consumoCidade: 11.7, consumoEstrada: 14.7),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Strada',        motor: '1.3 Turbo Flex', categoria: 'Picape',      consumoCidade: 11.5, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Toro',          motor: '1.3 Turbo Flex', categoria: 'Picape',      consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Toro',          motor: '2.0 Diesel',     categoria: 'Picape',      consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford',       modelo: 'Maverick',      motor: '2.0 Turbo Flex', categoria: 'Picape',      consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'S10',           motor: '2.5 Flex',       categoria: 'Picape',      consumoCidade: 10.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'S10',           motor: '2.8 Diesel',     categoria: 'Picape',      consumoCidade: 9.5,  consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Hilux',         motor: '2.7 Flex',       categoria: 'Picape',      consumoCidade: 10.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Hilux',         motor: '2.8 Diesel',     categoria: 'Picape',      consumoCidade: 9.0,  consumoEstrada: 12.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Hilux SW4',     motor: '2.8 Diesel',     categoria: 'Picape',      consumoCidade: 9.5,  consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Nissan',     modelo: 'Frontier',      motor: '2.3 Diesel',     categoria: 'Picape',      consumoCidade: 10.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford',       modelo: 'Ranger',        motor: '2.0 Diesel',     categoria: 'Picape',      consumoCidade: 10.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford',       modelo: 'Ranger',        motor: '3.0 Diesel V6',  categoria: 'Picape',      consumoCidade: 9.5,  consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Amarok',        motor: '2.0 Diesel',     categoria: 'Picape',      consumoCidade: 9.5,  consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Amarok',        motor: '3.0 Diesel V6',  categoria: 'Picape',      consumoCidade: 8.5,  consumoEstrada: 11.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mitsubishi', modelo: 'L200 Triton',   motor: '2.4 Diesel',     categoria: 'Picape',      consumoCidade: 9.0,  consumoEstrada: 12.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Jeep',       modelo: 'Gladiator',     motor: '3.0 Diesel',     categoria: 'Picape',      consumoCidade: 8.5,  consumoEstrada: 11.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'RAM',        modelo: '1500',          motor: '5.7 V8',         categoria: 'Picape',      consumoCidade: 6.5,  consumoEstrada: 9.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — URBANA
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Pop 110i',       motor: '109cc',          categoria: 'Urbana',      consumoCidade: 49.0, consumoEstrada: 53.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Biz 110i',       motor: '109cc',          categoria: 'Urbana',      consumoCidade: 47.0, consumoEstrada: 51.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CG 125 Titan',   motor: '125cc',          categoria: 'Urbana',      consumoCidade: 44.0, consumoEstrada: 48.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CG 125 Fan',     motor: '125cc',          categoria: 'Urbana',      consumoCidade: 44.0, consumoEstrada: 48.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CG 160 Titan',   motor: '162cc',          categoria: 'Urbana',      consumoCidade: 40.0, consumoEstrada: 43.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CG 160 Fan',     motor: '162cc',          categoria: 'Urbana',      consumoCidade: 40.0, consumoEstrada: 43.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CG 160 Cargo',   motor: '162cc',          categoria: 'Urbana',      consumoCidade: 38.0, consumoEstrada: 41.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'NXR 125 Bros',   motor: '125cc',          categoria: 'Urbana',      consumoCidade: 42.0, consumoEstrada: 46.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'NXR 150 Bros',   motor: '149cc',          categoria: 'Urbana',      consumoCidade: 38.0, consumoEstrada: 42.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'NXR Bros 160',   motor: '162cc',          categoria: 'Urbana',      consumoCidade: 35.0, consumoEstrada: 39.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'XRE 190',        motor: '184cc',          categoria: 'Urbana',      consumoCidade: 32.0, consumoEstrada: 36.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Factor 125',     motor: '124cc',          categoria: 'Urbana',      consumoCidade: 40.0, consumoEstrada: 44.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Factor 150',     motor: '149cc',          categoria: 'Urbana',      consumoCidade: 38.0, consumoEstrada: 42.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'FZ 150 / Fazer 150', motor: '149cc',      categoria: 'Urbana',      consumoCidade: 38.0, consumoEstrada: 42.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'YBR 125',        motor: '124cc',          categoria: 'Urbana',      consumoCidade: 40.0, consumoEstrada: 44.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'YBR 150',        motor: '149cc',          categoria: 'Urbana',      consumoCidade: 38.0, consumoEstrada: 42.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Dafra',      modelo: 'Speed 150',      motor: '149cc',          categoria: 'Urbana',      consumoCidade: 36.0, consumoEstrada: 40.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — NAKED
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CB 250F Twister', motor: '249cc',         categoria: 'Naked',       consumoCidade: 28.0, consumoEstrada: 32.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CB 300F',         motor: '293cc',         categoria: 'Naked',       consumoCidade: 26.0, consumoEstrada: 30.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CB 300R Twister', motor: '293cc',         categoria: 'Naked',       consumoCidade: 28.0, consumoEstrada: 32.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'MT-15',           motor: '155cc',         categoria: 'Naked',       consumoCidade: 30.0, consumoEstrada: 34.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'FZ 25 / Fazer 250', motor: '249cc',       categoria: 'Naked',       consumoCidade: 27.0, consumoEstrada: 31.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'BMW',        modelo: 'G 310 R',         motor: '313cc',         categoria: 'Naked',       consumoCidade: 25.0, consumoEstrada: 29.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'KTM',        modelo: 'Duke 390',        motor: '373cc',         categoria: 'Naked',       consumoCidade: 23.0, consumoEstrada: 27.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'MT-03',           motor: '321cc',         categoria: 'Naked',       consumoCidade: 23.0, consumoEstrada: 27.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Z400',            motor: '399cc',         categoria: 'Naked',       consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CB 500F',         motor: '471cc',         categoria: 'Naked',       consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Meteor 350',   motor: '349cc',         categoria: 'Naked',       consumoCidade: 28.0, consumoEstrada: 32.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Classic 350',  motor: '349cc',         categoria: 'Naked',       consumoCidade: 27.0, consumoEstrada: 31.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Z650',            motor: '649cc',         categoria: 'Naked',       consumoCidade: 19.0, consumoEstrada: 23.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CB 650R',         motor: '649cc',         categoria: 'Naked',       consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'MT-07',           motor: '689cc',         categoria: 'Naked',       consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'GSX-S750',        motor: '749cc',         categoria: 'Naked',       consumoCidade: 17.0, consumoEstrada: 21.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CB 750 Hornet',   motor: '755cc',         categoria: 'Naked',       consumoCidade: 17.0, consumoEstrada: 21.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Z900',            motor: '898cc',         categoria: 'Naked',       consumoCidade: 16.0, consumoEstrada: 20.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'MT-09',           motor: '890cc',         categoria: 'Naked',       consumoCidade: 15.0, consumoEstrada: 19.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CB 1000R',        motor: '998cc',         categoria: 'Naked',       consumoCidade: 15.0, consumoEstrada: 19.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — TRAIL / ADVENTURE
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'XTZ 125',         motor: '124cc',         categoria: 'Trail',       consumoCidade: 38.0, consumoEstrada: 42.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'XTZ 150 Crosser', motor: '149cc',         categoria: 'Trail',       consumoCidade: 36.0, consumoEstrada: 40.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'XTZ 150 Crosser Z', motor: '149cc',       categoria: 'Trail',       consumoCidade: 35.0, consumoEstrada: 39.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Tornado XR 250',  motor: '249cc',         categoria: 'Trail',       consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'XRE 300',         motor: '292cc',         categoria: 'Trail',       consumoCidade: 28.0, consumoEstrada: 32.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'XRE 300 ABS',     motor: '292cc',         categoria: 'Trail',       consumoCidade: 27.0, consumoEstrada: 31.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CRF 300L',        motor: '286cc',         categoria: 'Trail',       consumoCidade: 28.0, consumoEstrada: 33.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Himalayan 411', motor: '411cc',        categoria: 'Trail',       consumoCidade: 25.0, consumoEstrada: 29.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Lander 250',      motor: '249cc',         categoria: 'Trail',       consumoCidade: 25.0, consumoEstrada: 29.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'KTM',        modelo: '390 Adventure',   motor: '373cc',         categoria: 'Trail',       consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Versys 300',      motor: '296cc',         categoria: 'Trail',       consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'NC 750X',         motor: '745cc',         categoria: 'Trail',       consumoCidade: 22.0, consumoEstrada: 27.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'V-Strom 650',     motor: '645cc',         categoria: 'Trail',       consumoCidade: 19.0, consumoEstrada: 23.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Versys 650',      motor: '649cc',         categoria: 'Trail',       consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'BMW',        modelo: 'F 750 GS',        motor: '853cc',         categoria: 'Trail',       consumoCidade: 19.0, consumoEstrada: 23.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'BMW',        modelo: 'F 850 GS',        motor: '853cc',         categoria: 'Trail',       consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'XTZ 250 Ténéré',  motor: '249cc',         categoria: 'Trail',       consumoCidade: 25.0, consumoEstrada: 30.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'XT 660Z Ténéré',  motor: '659cc',         categoria: 'Trail',       consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'XT 660R',         motor: '659cc',         categoria: 'Trail',       consumoCidade: 17.0, consumoEstrada: 21.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Ténéré 700',      motor: '689cc',         categoria: 'Trail',       consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Ténéré 700 World Raid', motor: '689cc',    categoria: 'Trail',       consumoCidade: 17.0, consumoEstrada: 21.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Triumph',    modelo: 'Tiger 900',       motor: '888cc',         categoria: 'Trail',       consumoCidade: 17.0, consumoEstrada: 21.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Africa Twin 1100', motor: '1084cc',       categoria: 'Trail',       consumoCidade: 16.0, consumoEstrada: 20.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'BMW',        modelo: 'R 1250 GS',       motor: '1254cc',        categoria: 'Trail',       consumoCidade: 14.0, consumoEstrada: 18.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — SCOOTER
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Shineray',   modelo: 'Jet 50',          motor: '49cc',          categoria: 'Scooter',     consumoCidade: 50.0, consumoEstrada: 55.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Elite 125',       motor: '124cc',         categoria: 'Scooter',     consumoCidade: 42.0, consumoEstrada: 46.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Lead 110',        motor: '109cc',         categoria: 'Scooter',     consumoCidade: 44.0, consumoEstrada: 48.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'Burgman 125',     motor: '124cc',         categoria: 'Scooter',     consumoCidade: 41.0, consumoEstrada: 45.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Fluo 125',        motor: '124cc',         categoria: 'Scooter',     consumoCidade: 40.0, consumoEstrada: 44.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'PCX 160',         motor: '160cc',         categoria: 'Scooter',     consumoCidade: 38.0, consumoEstrada: 42.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'NMAX 160',        motor: '155cc',         categoria: 'Scooter',     consumoCidade: 36.0, consumoEstrada: 40.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Aerox 155',       motor: '155cc',         categoria: 'Scooter',     consumoCidade: 33.0, consumoEstrada: 37.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kymco',      modelo: 'Agility 200',     motor: '163cc',         categoria: 'Scooter',     consumoCidade: 32.0, consumoEstrada: 36.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'ADV 160',         motor: '160cc',         categoria: 'Scooter',     consumoCidade: 31.0, consumoEstrada: 35.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'SH 300i',         motor: '279cc',         categoria: 'Scooter',     consumoCidade: 27.0, consumoEstrada: 31.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'Burgman 400',     motor: '399cc',         categoria: 'Scooter',     consumoCidade: 25.0, consumoEstrada: 29.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — ESPORTIVA
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'KTM',        modelo: 'RC 390',          motor: '373cc',         categoria: 'Esportiva',   consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'R3',              motor: '321cc',         categoria: 'Esportiva',   consumoCidade: 23.0, consumoEstrada: 27.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Ninja 400',       motor: '399cc',         categoria: 'Esportiva',   consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CBR 500R',        motor: '471cc',         categoria: 'Esportiva',   consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Ninja 650',       motor: '649cc',         categoria: 'Esportiva',   consumoCidade: 19.0, consumoEstrada: 23.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CBR 650R',        motor: '649cc',         categoria: 'Esportiva',   consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'R7',              motor: '689cc',         categoria: 'Esportiva',   consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Ninja ZX-6R',     motor: '636cc',         categoria: 'Esportiva',   consumoCidade: 15.0, consumoEstrada: 19.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CBR 1000RR-R',    motor: '999cc',         categoria: 'Esportiva',   consumoCidade: 14.0, consumoEstrada: 18.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Ninja ZX-10R',    motor: '998cc',         categoria: 'Esportiva',   consumoCidade: 13.0, consumoEstrada: 17.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'R1',              motor: '998cc',         categoria: 'Esportiva',   consumoCidade: 13.0, consumoEstrada: 17.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'BMW',        modelo: 'S 1000 RR',       motor: '999cc',         categoria: 'Esportiva',   consumoCidade: 13.0, consumoEstrada: 17.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — CUSTOM / TOURING
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Interceptor 650', motor: '648cc',      categoria: 'Custom',      consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Triumph',    modelo: 'Bonneville T120',  motor: '1200cc',        categoria: 'Custom',      consumoCidade: 17.0, consumoEstrada: 21.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Iron 883',    motor: '883cc',         categoria: 'Custom',      consumoCidade: 14.0, consumoEstrada: 17.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'Boulevard M800',   motor: '805cc',         categoria: 'Custom',      consumoCidade: 15.0, consumoEstrada: 18.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Sportster S 1250', motor: '1252cc',   categoria: 'Custom',      consumoCidade: 12.0, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Gold Wing 1800',   motor: '1833cc',        categoria: 'Custom',      consumoCidade: 12.0, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'BMW',        modelo: 'K 1600 GTL',       motor: '1649cc',        categoria: 'Custom',      consumoCidade: 12.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Softail 107',  motor: '1746cc',       categoria: 'Custom',      consumoCidade: 11.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Road Glide 117', motor: '1923cc',     categoria: 'Custom',      consumoCidade: 10.0, consumoEstrada: 13.0),

  // ═══════════════════════════════════════════════════════════════
  //  CARROS ADICIONAIS — HATCH
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Up!',           motor: '1.0 Flex',       categoria: 'Hatch',      consumoCidade: 13.8, consumoEstrada: 15.8),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai',    modelo: 'HB20',          motor: '1.6 Flex',       categoria: 'Hatch',      consumoCidade: 11.5, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Kia',        modelo: 'Picanto',       motor: '1.0',            categoria: 'Hatch',      consumoCidade: 13.5, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Citroën',    modelo: 'C3 Aircross',   motor: '1.6 Flex',       categoria: 'Hatch',      consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Etios Hatch',   motor: '1.3 Flex',       categoria: 'Hatch',      consumoCidade: 13.0, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda',      modelo: 'City Hatch',    motor: '1.5 Flex',       categoria: 'Hatch',      consumoCidade: 12.5, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault',    modelo: 'Clio',          motor: '1.0 Flex',       categoria: 'Hatch',      consumoCidade: 13.0, consumoEstrada: 15.5),

  // ═══════════════════════════════════════════════════════════════
  //  CARROS ADICIONAIS — SEDAN
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda',      modelo: 'City',          motor: '1.5 Flex',       categoria: 'Sedan',      consumoCidade: 12.5, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Jetta',         motor: '1.4 TSI Flex',   categoria: 'Sedan',      consumoCidade: 12.0, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai',    modelo: 'Elantra',       motor: '2.0 Flex',       categoria: 'Sedan',      consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Nissan',     modelo: 'Sentra',        motor: '2.0 Flex',       categoria: 'Sedan',      consumoCidade: 11.3, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Etios Sedan',   motor: '1.5 Flex',       categoria: 'Sedan',      consumoCidade: 12.8, consumoEstrada: 15.8),
  VeiculoConsumo(tipo: 'Carro', marca: 'Kia',        modelo: 'Cerato',        motor: '1.6',            categoria: 'Sedan',      consumoCidade: 11.5, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Prius',         motor: '1.8 Hybrid',     categoria: 'Sedan',      consumoCidade: 18.9, consumoEstrada: 17.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Cobalt',        motor: '1.4 Flex',       categoria: 'Sedan',      consumoCidade: 12.0, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'BMW',        modelo: 'Série 5 520i',  motor: '2.0 Turbo',      categoria: 'Sedan',      consumoCidade: 9.5,  consumoEstrada: 12.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mercedes',   modelo: 'Classe E 200',  motor: '2.0 Turbo',      categoria: 'Sedan',      consumoCidade: 9.5,  consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Audi',       modelo: 'A4',            motor: '2.0 TFSI',       categoria: 'Sedan',      consumoCidade: 10.0, consumoEstrada: 13.0),

  // ═══════════════════════════════════════════════════════════════
  //  CARROS ADICIONAIS — SUV
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Kia',        modelo: 'Sportage',      motor: '1.6 Turbo',      categoria: 'SUV',        consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Kia',        modelo: 'Stonic',        motor: '1.0 Turbo',      categoria: 'SUV',        consumoCidade: 12.0, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Kia',        modelo: 'Sorento',       motor: '2.5',            categoria: 'SUV',        consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mitsubishi', modelo: 'Pajero Sport',  motor: '2.4 Diesel',     categoria: 'SUV',        consumoCidade: 9.5,  consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Land Cruiser',  motor: '4.0 V6',         categoria: 'SUV',        consumoCidade: 7.5,  consumoEstrada: 10.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Jeep',       modelo: 'Wrangler',      motor: '2.0 Turbo',      categoria: 'SUV',        consumoCidade: 9.0,  consumoEstrada: 11.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Fastback',      motor: '1.0 Turbo Flex', categoria: 'SUV',        consumoCidade: 12.0, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford',       modelo: 'Bronco Sport',  motor: '2.0 Turbo',      categoria: 'SUV',        consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Caoa Chery', modelo: 'Tiggo 8 Pro',   motor: '1.6 Turbo Flex', categoria: 'SUV',        consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'GWM',        modelo: 'Tank 300',      motor: '2.0 Turbo',      categoria: 'SUV',        consumoCidade: 9.5,  consumoEstrada: 12.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mercedes',   modelo: 'GLB 200',       motor: '1.3 Turbo',      categoria: 'SUV',        consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'BMW',        modelo: 'X5',            motor: '3.0 Turbo',      categoria: 'SUV',        consumoCidade: 8.5,  consumoEstrada: 11.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Audi',       modelo: 'Q5',            motor: '2.0 TFSI',       categoria: 'SUV',        consumoCidade: 9.5,  consumoEstrada: 12.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai',    modelo: 'Santa Fe',      motor: '2.5 Flex',       categoria: 'SUV',        consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Trailblazer',   motor: '2.8 Diesel',     categoria: 'SUV',        consumoCidade: 9.5,  consumoEstrada: 12.5),

  // ═══════════════════════════════════════════════════════════════
  //  CARROS ADICIONAIS — MINIVAN / VAN
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Spin',          motor: '1.8 Flex',       categoria: 'Picape',      consumoCidade: 11.4, consumoEstrada: 13.2),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Doblò',         motor: '1.4 Flex',       categoria: 'Picape',      consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Kia',        modelo: 'Carnival',      motor: '3.5 V6',         categoria: 'Picape',      consumoCidade: 8.5,  consumoEstrada: 11.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS ADICIONAIS — URBANA
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CG 125 Fan',      motor: '124cc',          categoria: 'Urbana',      consumoCidade: 43.0, consumoEstrada: 47.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Titan 150',       motor: '149cc',          categoria: 'Urbana',      consumoCidade: 37.0, consumoEstrada: 40.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Fazer 150',       motor: '149cc',          categoria: 'Urbana',      consumoCidade: 36.0, consumoEstrada: 40.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Neo 115',         motor: '113cc',          categoria: 'Urbana',      consumoCidade: 45.0, consumoEstrada: 49.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CB 250 Twister',  motor: '249cc',          categoria: 'Urbana',      consumoCidade: 30.0, consumoEstrada: 34.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Fazer 250',       motor: '249cc',          categoria: 'Urbana',      consumoCidade: 28.0, consumoEstrada: 32.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS ADICIONAIS — NAKED
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Z300',            motor: '296cc',          categoria: 'Naked',       consumoCidade: 23.0, consumoEstrada: 27.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Hornet CB 600F',  motor: '599cc',          categoria: 'Naked',       consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Triumph',    modelo: 'Street Triple 765', motor: '765cc',        categoria: 'Naked',       consumoCidade: 15.0, consumoEstrada: 19.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Ducati',     modelo: 'Monster 937',     motor: '937cc',          categoria: 'Naked',       consumoCidade: 14.0, consumoEstrada: 18.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'XJ6',             motor: '600cc',          categoria: 'Naked',       consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'ER-6N',           motor: '649cc',          categoria: 'Naked',       consumoCidade: 19.0, consumoEstrada: 23.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS ADICIONAIS — TRAIL
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'BMW',        modelo: 'G 310 GS',        motor: '313cc',          categoria: 'Trail',       consumoCidade: 24.0, consumoEstrada: 28.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'KTM',        modelo: '790 Adventure',   motor: '799cc',          categoria: 'Trail',       consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Triumph',    modelo: 'Tiger 660',       motor: '660cc',          categoria: 'Trail',       consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Ducati',     modelo: 'Multistrada V2',  motor: '937cc',          categoria: 'Trail',       consumoCidade: 15.0, consumoEstrada: 19.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CB 500X',         motor: '471cc',          categoria: 'Trail',       consumoCidade: 22.0, consumoEstrada: 26.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS ADICIONAIS — SCOOTER
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'PCX 150',         motor: '149cc',          categoria: 'Scooter',     consumoCidade: 38.0, consumoEstrada: 43.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'BWS 125',         motor: '124cc',          categoria: 'Scooter',     consumoCidade: 38.0, consumoEstrada: 42.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Dafra',      modelo: 'Citycom 300i',    motor: '278cc',          categoria: 'Scooter',     consumoCidade: 27.0, consumoEstrada: 31.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Shineray',   modelo: 'Ares 150',        motor: '149cc',          categoria: 'Scooter',     consumoCidade: 36.0, consumoEstrada: 40.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS ADICIONAIS — ESPORTIVA
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CBR 250R',        motor: '249cc',          categoria: 'Esportiva',   consumoCidade: 25.0, consumoEstrada: 29.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Ninja 300',       motor: '296cc',          categoria: 'Esportiva',   consumoCidade: 23.0, consumoEstrada: 27.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'GSX-R 750',       motor: '750cc',          categoria: 'Esportiva',   consumoCidade: 15.0, consumoEstrada: 19.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Ducati',     modelo: 'Panigale V4',     motor: '1103cc',         categoria: 'Esportiva',   consumoCidade: 11.0, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Triumph',    modelo: 'Daytona 660',     motor: '660cc',          categoria: 'Esportiva',   consumoCidade: 17.0, consumoEstrada: 21.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS ADICIONAIS — CUSTOM
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Street 750',  motor: '749cc',         categoria: 'Custom',      consumoCidade: 16.0, consumoEstrada: 20.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'V-Max 1700',      motor: '1679cc',         categoria: 'Custom',      consumoCidade: 11.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Vulcan S 650',    motor: '649cc',          categoria: 'Custom',      consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Indian',     modelo: 'Scout 1133',      motor: '1133cc',         categoria: 'Custom',      consumoCidade: 13.0, consumoEstrada: 16.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — CUSTOM ADICIONAIS
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Fat Boy 114',      motor: '1868cc',    categoria: 'Custom',      consumoCidade: 10.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Heritage Classic', motor: '1868cc',    categoria: 'Custom',      consumoCidade: 10.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Low Rider S',      motor: '1868cc',    categoria: 'Custom',      consumoCidade: 11.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Street Bob 114',   motor: '1868cc',    categoria: 'Custom',      consumoCidade: 11.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Pan America 1250', motor: '1252cc',    categoria: 'Custom',      consumoCidade: 13.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Nightster 975',    motor: '975cc',     categoria: 'Custom',      consumoCidade: 15.0, consumoEstrada: 18.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Triumph',    modelo: 'Thunderbird 1700',  motor: '1700cc',        categoria: 'Custom',      consumoCidade: 13.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Triumph',    modelo: 'Speedmaster 1200',  motor: '1200cc',        categoria: 'Custom',      consumoCidade: 15.0, consumoEstrada: 19.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Indian',     modelo: 'Chief Dark Horse',   motor: '1811cc',       categoria: 'Custom',      consumoCidade: 12.0, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Indian',     modelo: 'Springfield',        motor: '1811cc',       categoria: 'Custom',      consumoCidade: 11.5, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Moto', marca: 'Indian',     modelo: 'Chieftain',          motor: '1811cc',       categoria: 'Custom',      consumoCidade: 11.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Vulcan 900',         motor: '903cc',        categoria: 'Custom',      consumoCidade: 17.0, consumoEstrada: 21.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Vulcan 1700',        motor: '1700cc',       categoria: 'Custom',      consumoCidade: 13.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'Intruder 125',       motor: '124cc',        categoria: 'Custom',      consumoCidade: 40.0, consumoEstrada: 44.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'Intruder 150',       motor: '149cc',        categoria: 'Custom',      consumoCidade: 35.0, consumoEstrada: 39.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'Intruder 1800',      motor: '1783cc',       categoria: 'Custom',      consumoCidade: 12.0, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Shadow 750',         motor: '745cc',        categoria: 'Custom',      consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Biz 125',            motor: '124cc',        categoria: 'Custom',      consumoCidade: 44.0, consumoEstrada: 48.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Super Meteor 650', motor: '648cc',      categoria: 'Custom',      consumoCidade: 21.0, consumoEstrada: 25.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Thunderbird 500',  motor: '499cc',      categoria: 'Custom',      consumoCidade: 24.0, consumoEstrada: 28.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Drag Star 950',      motor: '942cc',        categoria: 'Custom',      consumoCidade: 15.0, consumoEstrada: 18.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Star Venture 1900',  motor: '1854cc',       categoria: 'Custom',      consumoCidade: 10.0, consumoEstrada: 13.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — CUSTOM HONDA SHADOW (série completa)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Shadow 125',          motor: '124cc',        categoria: 'Custom',      consumoCidade: 40.0, consumoEstrada: 44.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Shadow 600',          motor: '583cc',        categoria: 'Custom',      consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Shadow 750',          motor: '745cc',        categoria: 'Custom',      consumoCidade: 17.0, consumoEstrada: 21.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Shadow 1100',         motor: '1099cc',       categoria: 'Custom',      consumoCidade: 14.0, consumoEstrada: 18.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Steed 600',           motor: '583cc',        categoria: 'Custom',      consumoCidade: 18.0, consumoEstrada: 22.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — CUSTOM YAMAHA (série Virago / V-Star)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Virago 250',          motor: '249cc',        categoria: 'Custom',      consumoCidade: 28.0, consumoEstrada: 32.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Virago 535',          motor: '535cc',        categoria: 'Custom',      consumoCidade: 20.0, consumoEstrada: 24.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Virago 1100',         motor: '1063cc',       categoria: 'Custom',      consumoCidade: 14.0, consumoEstrada: 18.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'V-Star 650',          motor: '649cc',        categoria: 'Custom',      consumoCidade: 19.0, consumoEstrada: 23.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'V-Star 1300',         motor: '1304cc',       categoria: 'Custom',      consumoCidade: 13.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Drag Star 650',       motor: '649cc',        categoria: 'Custom',      consumoCidade: 19.0, consumoEstrada: 23.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Drag Star 1100',      motor: '1063cc',       categoria: 'Custom',      consumoCidade: 14.0, consumoEstrada: 17.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Bolt 950',            motor: '942cc',        categoria: 'Custom',      consumoCidade: 15.0, consumoEstrada: 19.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — CUSTOM SUZUKI INTRUDER (série completa)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'Intruder 250',        motor: '249cc',        categoria: 'Custom',      consumoCidade: 26.0, consumoEstrada: 30.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'Intruder 600',        motor: '599cc',        categoria: 'Custom',      consumoCidade: 19.0, consumoEstrada: 23.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'Intruder 1400',       motor: '1360cc',       categoria: 'Custom',      consumoCidade: 13.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'Boulevard C50 800',   motor: '805cc',        categoria: 'Custom',      consumoCidade: 16.0, consumoEstrada: 20.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'Boulevard C90 1500',  motor: '1462cc',       categoria: 'Custom',      consumoCidade: 12.0, consumoEstrada: 15.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — CUSTOM HARLEY-DAVIDSON (modelos adicionais)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Forty-Eight 1200',   motor: '1202cc',  categoria: 'Custom',      consumoCidade: 13.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Sportster 1200 Custom', motor: '1202cc', categoria: 'Custom',   consumoCidade: 13.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Dyna Super Glide',   motor: '1584cc',  categoria: 'Custom',      consumoCidade: 11.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Fat Bob 114',        motor: '1868cc',  categoria: 'Custom',      consumoCidade: 10.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Breakout 117',       motor: '1923cc',  categoria: 'Custom',      consumoCidade: 10.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Road King 114',      motor: '1868cc',  categoria: 'Custom',      consumoCidade: 10.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Ultra Limited 117',  motor: '1923cc',  categoria: 'Custom',      consumoCidade: 10.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Street Glide 117',   motor: '1923cc',  categoria: 'Custom',      consumoCidade: 10.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'CVO Road Glide 121', motor: '1977cc',  categoria: 'Custom',      consumoCidade: 9.5,  consumoEstrada: 12.5),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — BAJAJ
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Bajaj',      modelo: 'Pulsar NS 160',       motor: '160cc',        categoria: 'Naked',       consumoCidade: 38.0, consumoEstrada: 44.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Bajaj',      modelo: 'Pulsar NS 200',       motor: '199cc',        categoria: 'Naked',       consumoCidade: 34.0, consumoEstrada: 40.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Bajaj',      modelo: 'Pulsar RS 200',       motor: '199cc',        categoria: 'Esportiva',   consumoCidade: 33.0, consumoEstrada: 38.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Bajaj',      modelo: 'Dominar 400',         motor: '373cc',        categoria: 'Trail',       consumoCidade: 27.0, consumoEstrada: 32.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Bajaj',      modelo: 'Dominar 250',         motor: '248cc',        categoria: 'Trail',       consumoCidade: 30.0, consumoEstrada: 35.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Bajaj',      modelo: 'Avenger Street 220',  motor: '220cc',        categoria: 'Custom',      consumoCidade: 32.0, consumoEstrada: 37.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Bajaj',      modelo: 'Avenger Cruise 220',  motor: '220cc',        categoria: 'Custom',      consumoCidade: 31.0, consumoEstrada: 36.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Bajaj',      modelo: 'Rouser NS 160',       motor: '160cc',        categoria: 'Naked',       consumoCidade: 38.0, consumoEstrada: 44.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Bajaj',      modelo: 'Rouser NS 200',       motor: '199cc',        categoria: 'Naked',       consumoCidade: 34.0, consumoEstrada: 40.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Bajaj',      modelo: 'CT 100',              motor: '102cc',        categoria: 'Urbana',      consumoCidade: 55.0, consumoEstrada: 60.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Bajaj',      modelo: 'Platina 110',         motor: '115cc',        categoria: 'Urbana',      consumoCidade: 50.0, consumoEstrada: 55.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Bajaj',      modelo: 'Boxer 150',           motor: '150cc',        categoria: 'Urbana',      consumoCidade: 42.0, consumoEstrada: 47.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — CUSTOM KAWASAKI
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Eliminator 500',      motor: '451cc',        categoria: 'Custom',      consumoCidade: 21.0, consumoEstrada: 25.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Vulcan S 650',        motor: '649cc',        categoria: 'Custom',      consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Vulcan 900 Classic',  motor: '903cc',        categoria: 'Custom',      consumoCidade: 17.0, consumoEstrada: 21.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Vulcan 1700 Voyager', motor: '1700cc',       categoria: 'Custom',      consumoCidade: 13.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Mean Streak 1600',    motor: '1552cc',       categoria: 'Custom',      consumoCidade: 12.0, consumoEstrada: 15.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — URBANA ADICIONAIS
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CG 160 Start',        motor: '162cc',        categoria: 'Urbana',      consumoCidade: 40.0, consumoEstrada: 43.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CG 150 Titan ESD',    motor: '149cc',        categoria: 'Urbana',      consumoCidade: 37.0, consumoEstrada: 40.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Haojue',     modelo: 'NK 150',              motor: '149cc',        categoria: 'Urbana',      consumoCidade: 36.0, consumoEstrada: 40.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Haojue',     modelo: 'DR 160',              motor: '162cc',        categoria: 'Urbana',      consumoCidade: 38.0, consumoEstrada: 42.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Dafra',      modelo: 'Apache 150',          motor: '149cc',        categoria: 'Urbana',      consumoCidade: 35.0, consumoEstrada: 39.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Shineray',   modelo: 'SHI 150',             motor: '149cc',        categoria: 'Urbana',      consumoCidade: 35.0, consumoEstrada: 39.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kasinski',   modelo: 'Comet 150',           motor: '149cc',        categoria: 'Urbana',      consumoCidade: 34.0, consumoEstrada: 38.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CB 190R',             motor: '184cc',        categoria: 'Urbana',      consumoCidade: 31.0, consumoEstrada: 35.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — NAKED ADICIONAIS
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'KTM',        modelo: 'Duke 200',            motor: '199cc',        categoria: 'Naked',       consumoCidade: 28.0, consumoEstrada: 32.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'KTM',        modelo: 'Duke 250',            motor: '248cc',        categoria: 'Naked',       consumoCidade: 26.0, consumoEstrada: 30.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'BMW',        modelo: 'F 900 R',             motor: '895cc',        categoria: 'Naked',       consumoCidade: 17.0, consumoEstrada: 21.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Triumph',    modelo: 'Speed Triple 1200',   motor: '1160cc',       categoria: 'Naked',       consumoCidade: 14.0, consumoEstrada: 18.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Ducati',     modelo: 'Monster 1200',        motor: '1198cc',       categoria: 'Naked',       consumoCidade: 13.0, consumoEstrada: 17.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Z125 Pro',            motor: '125cc',        categoria: 'Naked',       consumoCidade: 45.0, consumoEstrada: 50.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — TRAIL ADICIONAIS
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CRF 250F',            motor: '249cc',        categoria: 'Trail',       consumoCidade: 30.0, consumoEstrada: 35.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'KLX 300',             motor: '292cc',        categoria: 'Trail',       consumoCidade: 28.0, consumoEstrada: 33.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'KTM',        modelo: '690 Enduro R',        motor: '692cc',        categoria: 'Trail',       consumoCidade: 19.0, consumoEstrada: 23.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'BMW',        modelo: 'R 1250 GS Adventure', motor: '1254cc',       categoria: 'Trail',       consumoCidade: 14.0, consumoEstrada: 18.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Ducati',     modelo: 'Multistrada 1260',    motor: '1262cc',       categoria: 'Trail',       consumoCidade: 13.0, consumoEstrada: 17.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'V-Strom 1050',        motor: '1037cc',       categoria: 'Trail',       consumoCidade: 16.0, consumoEstrada: 20.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — SCOOTER ADICIONAIS
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Vespa',      modelo: 'Primavera 150',       motor: '155cc',        categoria: 'Scooter',     consumoCidade: 30.0, consumoEstrada: 34.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Vespa',      modelo: 'GTS 300',             motor: '278cc',        categoria: 'Scooter',     consumoCidade: 24.0, consumoEstrada: 28.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Piaggio',    modelo: 'Liberty 150',         motor: '155cc',        categoria: 'Scooter',     consumoCidade: 30.0, consumoEstrada: 34.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'Forza 300',           motor: '279cc',        categoria: 'Scooter',     consumoCidade: 26.0, consumoEstrada: 30.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'T-MAX 560',           motor: '562cc',        categoria: 'Scooter',     consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',     modelo: 'Neo 125',             motor: '124cc',        categoria: 'Scooter',     consumoCidade: 42.0, consumoEstrada: 46.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — ESPORTIVA ADICIONAIS
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Ninja 250',           motor: '249cc',        categoria: 'Esportiva',   consumoCidade: 24.0, consumoEstrada: 28.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',      modelo: 'CBR 300R',            motor: '286cc',        categoria: 'Esportiva',   consumoCidade: 25.0, consumoEstrada: 29.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki',   modelo: 'Ninja 1000 SX',       motor: '1043cc',       categoria: 'Esportiva',   consumoCidade: 15.0, consumoEstrada: 19.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki',     modelo: 'GSX-R 1000',          motor: '999cc',        categoria: 'Esportiva',   consumoCidade: 13.0, consumoEstrada: 17.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'BMW',        modelo: 'S 1000 XR',           motor: '999cc',        categoria: 'Esportiva',   consumoCidade: 15.0, consumoEstrada: 19.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Ducati',     modelo: 'Streetfighter V4',    motor: '1103cc',       categoria: 'Esportiva',   consumoCidade: 12.0, consumoEstrada: 16.0),

  // ═══════════════════════════════════════════════════════════════
  //  ROYAL ENFIELD — LINEUP COMPLETO
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Bullet 350',         motor: '346cc',  categoria: 'Naked',     consumoCidade: 30.0, consumoEstrada: 34.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Hunter 350',         motor: '349cc',  categoria: 'Naked',     consumoCidade: 29.0, consumoEstrada: 33.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Classic 500',        motor: '499cc',  categoria: 'Naked',     consumoCidade: 24.0, consumoEstrada: 28.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Guerrilla 450',      motor: '452cc',  categoria: 'Naked',     consumoCidade: 27.0, consumoEstrada: 31.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Scram 411',          motor: '411cc',  categoria: 'Trail',     consumoCidade: 26.0, consumoEstrada: 30.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Himalayan 450',      motor: '452cc',  categoria: 'Trail',     consumoCidade: 26.0, consumoEstrada: 30.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Continental GT 650', motor: '648cc',  categoria: 'Esportiva', consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Shotgun 650',        motor: '648cc',  categoria: 'Custom',    consumoCidade: 21.0, consumoEstrada: 25.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Bear 650',           motor: '648cc',  categoria: 'Custom',    consumoCidade: 21.0, consumoEstrada: 25.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Royal Enfield', modelo: 'Thunderbird 350X',   motor: '346cc',  categoria: 'Custom',    consumoCidade: 28.0, consumoEstrada: 32.0),

  // ═══════════════════════════════════════════════════════════════
  //  HARLEY-DAVIDSON — LINEUP COMPLETO
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Iron 1200',                  motor: '1202cc', categoria: 'Custom', consumoCidade: 13.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Forty-Eight Special',        motor: '1202cc', categoria: 'Custom', consumoCidade: 13.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Street Rod 750',             motor: '749cc',  categoria: 'Custom', consumoCidade: 16.0, consumoEstrada: 20.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Deluxe 114',                 motor: '1868cc', categoria: 'Custom', consumoCidade: 10.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Low Rider ST 117',           motor: '1923cc', categoria: 'Custom', consumoCidade: 10.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Road King Special 114',      motor: '1868cc', categoria: 'Custom', consumoCidade: 10.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Street Glide Special',       motor: '1923cc', categoria: 'Custom', consumoCidade: 10.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Road Glide Special',         motor: '1923cc', categoria: 'Custom', consumoCidade: 10.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Road Glide Limited',         motor: '1923cc', categoria: 'Custom', consumoCidade: 10.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'CVO Street Glide 121',       motor: '1977cc', categoria: 'Custom', consumoCidade: 9.5,  consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Electra Glide Highway King', motor: '1923cc', categoria: 'Custom', consumoCidade: 10.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Pan America 1250 Special',   motor: '1252cc', categoria: 'Custom', consumoCidade: 13.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Dyna Low Rider',             motor: '1584cc', categoria: 'Custom', consumoCidade: 11.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Dyna Fat Bob',               motor: '1584cc', categoria: 'Custom', consumoCidade: 11.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Dyna Street Bob',            motor: '1584cc', categoria: 'Custom', consumoCidade: 11.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Harley-Davidson', modelo: 'Dyna Wide Glide',            motor: '1584cc', categoria: 'Custom', consumoCidade: 11.0, consumoEstrada: 14.0),

  // ═══════════════════════════════════════════════════════════════
  //  BYD
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'BYD',        modelo: 'Dolphin',       motor: 'EV 70kWh',       categoria: 'Hatch',  consumoCidade: 8.5,  consumoEstrada: 8.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'BYD',        modelo: 'Yuan Plus',     motor: 'EV 60kWh',       categoria: 'SUV',    consumoCidade: 8.0,  consumoEstrada: 7.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'BYD',        modelo: 'Tan',           motor: 'EV 108kWh',      categoria: 'SUV',    consumoCidade: 7.5,  consumoEstrada: 7.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'BYD',        modelo: 'Song Plus',     motor: '1.5 Turbo Flex', categoria: 'SUV',    consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'BYD',        modelo: 'Shark',         motor: '1.5 PHEV',       categoria: 'Picape', consumoCidade: 12.0, consumoEstrada: 14.0),

  // ═══════════════════════════════════════════════════════════════
  //  CHANGAN
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Changan',    modelo: 'Uni-T',         motor: '1.5 Turbo',      categoria: 'SUV',    consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Changan',    modelo: 'Uni-V',         motor: '1.5 Turbo',      categoria: 'Sedan',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Changan',    modelo: 'Hunter',        motor: '2.0 Diesel',     categoria: 'Picape', consumoCidade: 10.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Changan',    modelo: 'CS35 Plus',     motor: '1.4 Turbo',      categoria: 'SUV',    consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Changan',    modelo: 'CS55 Plus',     motor: '1.5 Turbo',      categoria: 'SUV',    consumoCidade: 11.5, consumoEstrada: 14.0),

  // ═══════════════════════════════════════════════════════════════
  //  VOLKSWAGEN (novos modelos)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Golf',          motor: '1.0 TSI Flex',   categoria: 'Hatch',  consumoCidade: 13.0, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Golf GTI',      motor: '2.0 TSI',        categoria: 'Hatch',  consumoCidade: 10.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Fox',           motor: '1.0 Flex',       categoria: 'Hatch',  consumoCidade: 12.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Fox',           motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 10.5, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Saveiro',       motor: '1.6 MSI Flex',   categoria: 'Picape', consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Crossfox',      motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Passat',        motor: '2.0 TSI',        categoria: 'Sedan',  consumoCidade: 10.0, consumoEstrada: 12.5),

  // ═══════════════════════════════════════════════════════════════
  //  FIAT (novos modelos)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Siena',         motor: '1.4 Flex',       categoria: 'Sedan',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Bravo',         motor: '1.8 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Linea',         motor: '1.8 Flex',       categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat',       modelo: 'Grand Siena',   motor: '1.6 Flex',       categoria: 'Sedan',  consumoCidade: 12.0, consumoEstrada: 14.5),

  // ═══════════════════════════════════════════════════════════════
  //  CHEVROLET (novos modelos)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Cruze Sedan',   motor: '1.4 Turbo Flex', categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Cruze Sport6',  motor: '1.4 Turbo Flex', categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Equinox',       motor: '2.0 Turbo Flex', categoria: 'SUV',    consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Trax',          motor: '1.0 Turbo Flex', categoria: 'SUV',    consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet',  modelo: 'Montana',       motor: '1.0 Turbo Flex', categoria: 'Picape', consumoCidade: 12.0, consumoEstrada: 15.0),

  // ═══════════════════════════════════════════════════════════════
  //  TOYOTA (novos modelos)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Corolla GR Sport', motor: '2.0 Flex',    categoria: 'Sedan',  consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'RAV4 Hybrid',   motor: '2.5 Hybrid',     categoria: 'SUV',    consumoCidade: 15.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota',     modelo: 'Yaris Cross',   motor: '1.5 Hybrid',     categoria: 'SUV',    consumoCidade: 17.0, consumoEstrada: 15.5),

  // ═══════════════════════════════════════════════════════════════
  //  HONDA (novos modelos)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda',      modelo: 'Accord',        motor: '1.5 Turbo',      categoria: 'Sedan',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda',      modelo: 'ZR-V',          motor: '1.5 Turbo Flex', categoria: 'SUV',    consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda',      modelo: 'HR-V',          motor: '1.5 Turbo Flex', categoria: 'SUV',    consumoCidade: 11.5, consumoEstrada: 14.5),

  // ═══════════════════════════════════════════════════════════════
  //  SUBARU
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Subaru',     modelo: 'Forester',      motor: '2.0 Boxer',      categoria: 'SUV',    consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Subaru',     modelo: 'Outback',       motor: '2.5 Boxer',      categoria: 'SUV',    consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Subaru',     modelo: 'Impreza',       motor: '2.0 Boxer Flex', categoria: 'Sedan',  consumoCidade: 10.5, consumoEstrada: 13.0),

  // ═══════════════════════════════════════════════════════════════
  //  JAC
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'JAC',        modelo: 'T50',           motor: '1.5 Turbo Flex', categoria: 'Picape', consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'JAC',        modelo: 'T60',           motor: '2.0 Diesel',     categoria: 'Picape', consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'JAC',        modelo: 'T8 Plus',       motor: '2.0 Diesel',     categoria: 'Picape', consumoCidade: 9.5,  consumoEstrada: 12.0),

  // ═══════════════════════════════════════════════════════════════
  //  RAM
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'RAM',        modelo: '700',           motor: '2.0 Diesel',     categoria: 'Picape', consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'RAM',        modelo: 'Rampage',       motor: '1.3 Turbo Flex', categoria: 'Picape', consumoCidade: 11.0, consumoEstrada: 13.5),

  // ═══════════════════════════════════════════════════════════════
  //  CAOA CHERY (novos modelos)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Caoa Chery', modelo: 'Arrizo 6',      motor: '1.5 Turbo Flex', categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Caoa Chery', modelo: 'Arrizo 5 Pro',  motor: '1.5 Turbo',      categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 14.0),

  // ═══════════════════════════════════════════════════════════════
  //  LIFAN
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Lifan',      modelo: 'T60',           motor: '1.8 Flex',       categoria: 'Picape', consumoCidade: 10.5, consumoEstrada: 13.0),

  // ═══════════════════════════════════════════════════════════════
  //  FIAT — MODELOS CLÁSSICOS / POPULARES
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Uno Mille',            motor: '1.0 Gasolina',   categoria: 'Hatch',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Uno Vivace',           motor: '1.0 Fire Flex',  categoria: 'Hatch',  consumoCidade: 13.0, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Uno Way',              motor: '1.0 Fire Flex',  categoria: 'Hatch',  consumoCidade: 13.0, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Palio Fire Economy',   motor: '1.0 Fire Flex',  categoria: 'Hatch',  consumoCidade: 13.5, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Palio',                motor: '1.0 Fire Flex',  categoria: 'Hatch',  consumoCidade: 13.0, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Palio Attractive',     motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Palio ELX',            motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Palio',                motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Palio Weekend',        motor: '1.0 Fire Flex',  categoria: 'Hatch',  consumoCidade: 13.0, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Palio Weekend',        motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Palio Sedan',          motor: '1.0 Fire Flex',  categoria: 'Sedan',  consumoCidade: 13.0, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Palio Sedan',          motor: '1.4 Flex',       categoria: 'Sedan',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Idea',                 motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 12.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Idea',                 motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Stilo',                motor: '1.8 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Punto',                motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Punto',                motor: '1.8 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Tempra',               motor: '2.0 Gasolina',   categoria: 'Sedan',  consumoCidade: 9.5,  consumoEstrada: 12.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Tipo',                 motor: '1.6 Flex',       categoria: 'Sedan',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Fiat', modelo: 'Doblò Cargo',          motor: '1.8 Flex',       categoria: 'Hatch',  consumoCidade: 10.5, consumoEstrada: 13.0),

  // ═══════════════════════════════════════════════════════════════
  //  CHEVROLET — MODELOS CLÁSSICOS / POPULARES
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Celta',           motor: '1.0 Flex',       categoria: 'Hatch',  consumoCidade: 12.5, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Celta',           motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Corsa Hatch',     motor: '1.0 Flex',       categoria: 'Hatch',  consumoCidade: 12.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Corsa Hatch',     motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Corsa Hatch',     motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Corsa Classic',   motor: '1.0 Flex',       categoria: 'Sedan',  consumoCidade: 12.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Corsa Classic',   motor: '1.4 Flex',       categoria: 'Sedan',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Corsa Sedan',     motor: '1.0 Flex',       categoria: 'Sedan',  consumoCidade: 12.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Corsa Wind',      motor: '1.0 Gasolina',   categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Astra Hatch',     motor: '1.8 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Astra Sedan',     motor: '1.8 Flex',       categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Astra',           motor: '2.0 Flex',       categoria: 'Hatch',  consumoCidade: 10.5, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Vectra',          motor: '2.0 Flex',       categoria: 'Sedan',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Vectra GT',       motor: '2.0 Turbo Flex', categoria: 'Sedan',  consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Meriva',          motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Meriva',          motor: '1.8 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Zafira',          motor: '2.0 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Blazer',          motor: '2.2 Flex',       categoria: 'SUV',    consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Blazer',          motor: '2.4 Flex',       categoria: 'SUV',    consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Agile',           motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 12.5, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Captiva',         motor: '2.0 Turbo Diesel', categoria: 'SUV', consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Cobalt',          motor: '1.8 Flex',       categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Classic',         motor: '1.0 VHC Flex',   categoria: 'Sedan',  consumoCidade: 13.0, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Chevrolet', modelo: 'Bolt EV',         motor: 'EV 65kWh',       categoria: 'Hatch',  consumoCidade: 7.0,  consumoEstrada: 6.5),

  // ═══════════════════════════════════════════════════════════════
  //  VOLKSWAGEN — MODELOS CLÁSSICOS / POPULARES
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Gol',            motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Gol',            motor: '1.0 Gasolina',   categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Gol Country',    motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Parati',         motor: '1.0 Flex',       categoria: 'Hatch',  consumoCidade: 12.5, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Parati',         motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Parati',         motor: '1.8 Flex',       categoria: 'Hatch',  consumoCidade: 10.5, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Spacefox',       motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Bora',           motor: '2.0 Flex',       categoria: 'Sedan',  consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Fusca / New Beetle', motor: '2.0 Flex',   categoria: 'Hatch',  consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Golf',           motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Golf',           motor: '2.0 Flex',       categoria: 'Hatch',  consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Jetta',          motor: '2.0 Flex',       categoria: 'Sedan',  consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Kombi',          motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'Touareg',        motor: '3.0 V6 Diesel',  categoria: 'SUV',    consumoCidade: 9.0,  consumoEstrada: 11.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Volkswagen', modelo: 'ID.4',           motor: 'EV 77kWh',       categoria: 'SUV',    consumoCidade: 6.5,  consumoEstrada: 6.0),

  // ═══════════════════════════════════════════════════════════════
  //  FORD — MODELOS CLÁSSICOS / POPULARES
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Fiesta Hatch',         motor: '1.0 Flex',       categoria: 'Hatch',  consumoCidade: 12.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Fiesta Hatch',         motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Fiesta Sedan',         motor: '1.0 Flex',       categoria: 'Sedan',  consumoCidade: 12.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Fiesta Sedan',         motor: '1.6 Flex',       categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Focus Hatch',          motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Focus Hatch',          motor: '2.0 Flex',       categoria: 'Hatch',  consumoCidade: 10.5, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Focus Sedan',          motor: '2.0 Flex',       categoria: 'Sedan',  consumoCidade: 10.5, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Focus',                motor: '2.0 Turbo EcoBoost', categoria: 'Sedan', consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'EcoSport',             motor: '1.6 Flex',       categoria: 'SUV',    consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'EcoSport',             motor: '2.0 Flex',       categoria: 'SUV',    consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'EcoSport',             motor: '1.5 Flex',       categoria: 'SUV',    consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Fusion',               motor: '2.5 Flex',       categoria: 'Sedan',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Fusion Hybrid',        motor: '2.0 Hybrid',     categoria: 'Sedan',  consumoCidade: 17.0, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Edge',                 motor: '2.0 EcoBoost',   categoria: 'SUV',    consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'F-250',                motor: '3.9 Diesel',     categoria: 'Picape', consumoCidade: 7.0,  consumoEstrada: 9.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Courier',              motor: '1.6 Flex',       categoria: 'Picape', consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Ford', modelo: 'Ranger',               motor: '2.3 Flex',       categoria: 'Picape', consumoCidade: 10.5, consumoEstrada: 13.0),

  // ═══════════════════════════════════════════════════════════════
  //  RENAULT — MODELOS CLÁSSICOS / POPULARES
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault', modelo: 'Clio Hatch',        motor: '1.0 Flex',       categoria: 'Hatch',  consumoCidade: 13.0, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault', modelo: 'Clio Sedan',        motor: '1.0 Flex',       categoria: 'Sedan',  consumoCidade: 13.0, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault', modelo: 'Clio Hatch',        motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault', modelo: 'Symbol',            motor: '1.6 Flex',       categoria: 'Sedan',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault', modelo: 'Mégane',            motor: '2.0 Flex',       categoria: 'Hatch',  consumoCidade: 10.5, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault', modelo: 'Mégane',            motor: '1.6 Flex',       categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault', modelo: 'Scénic',            motor: '2.0 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault', modelo: 'Laguna',            motor: '2.0 Flex',       categoria: 'Sedan',  consumoCidade: 11.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault', modelo: 'Sandero RS',        motor: '2.0 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault', modelo: 'Logan',             motor: '1.6 Flex',       categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Renault', modelo: 'Duster',            motor: '1.6 Flex',       categoria: 'SUV',    consumoCidade: 11.5, consumoEstrada: 14.0),

  // ═══════════════════════════════════════════════════════════════
  //  PEUGEOT — MODELOS POPULARES
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot', modelo: '206',               motor: '1.0 Flex',       categoria: 'Hatch',  consumoCidade: 12.5, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot', modelo: '206',               motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 12.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot', modelo: '206',               motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot', modelo: '207',               motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 12.0, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot', modelo: '207',               motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot', modelo: '207 Sedan',         motor: '1.6 Flex',       categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot', modelo: '307',               motor: '2.0 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot', modelo: '307',               motor: '1.6 Flex',       categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot', modelo: '408',               motor: '2.0 Flex',       categoria: 'Sedan',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Peugeot', modelo: '408 THP',           motor: '1.6 Turbo Flex', categoria: 'Sedan',  consumoCidade: 12.0, consumoEstrada: 14.5),

  // ═══════════════════════════════════════════════════════════════
  //  CITROËN — MODELOS POPULARES
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Citroën', modelo: 'C3',                motor: '1.0 Flex',       categoria: 'Hatch',  consumoCidade: 13.0, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Citroën', modelo: 'C3',                motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Citroën', modelo: 'C4',                motor: '2.0 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Citroën', modelo: 'C4 Pallas',         motor: '2.0 Flex',       categoria: 'Sedan',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Citroën', modelo: 'C4 Lounge',         motor: '1.6 Turbo Flex', categoria: 'Sedan',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Citroën', modelo: 'Xsara Picasso',     motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Citroën', modelo: 'C5',                motor: '2.0 Flex',       categoria: 'Sedan',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Citroën', modelo: 'Jumpy',             motor: '2.0 HDi Diesel', categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 14.0),

  // ═══════════════════════════════════════════════════════════════
  //  HYUNDAI / KIA — MODELOS POPULARES
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai', modelo: 'i30',               motor: '2.0 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai', modelo: 'i30',               motor: '1.4 Flex',       categoria: 'Hatch',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai', modelo: 'Azera',             motor: '3.0 V6',         categoria: 'Sedan',  consumoCidade: 9.0,  consumoEstrada: 11.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai', modelo: 'ix35',              motor: '2.0 Flex',       categoria: 'SUV',    consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Hyundai', modelo: 'Tucson Classic',    motor: '2.0 Flex',       categoria: 'SUV',    consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Kia',     modelo: 'Soul',              motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Kia',     modelo: 'Cadenza',           motor: '3.3 V6',         categoria: 'Sedan',  consumoCidade: 9.0,  consumoEstrada: 11.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Kia',     modelo: 'Mohave',            motor: '3.0 V6 Diesel',  categoria: 'SUV',    consumoCidade: 9.5,  consumoEstrada: 12.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Kia',     modelo: 'EV6',               motor: 'EV 77kWh',       categoria: 'SUV',    consumoCidade: 6.5,  consumoEstrada: 6.0),

  // ═══════════════════════════════════════════════════════════════
  //  NISSAN / MITSUBISHI — MODELOS POPULARES
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Nissan',     modelo: 'Tiida',          motor: '1.8 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Nissan',     modelo: 'Livina',         motor: '1.6 Flex',       categoria: 'Hatch',  consumoCidade: 12.5, consumoEstrada: 15.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Nissan',     modelo: 'Livina',         motor: '1.8 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Nissan',     modelo: 'Grand Livina',   motor: '1.8 Flex',       categoria: 'Hatch',  consumoCidade: 11.0, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mitsubishi', modelo: 'Lancer',         motor: '2.0 Flex',       categoria: 'Sedan',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mitsubishi', modelo: 'Galant',         motor: '2.4 Gasolina',   categoria: 'Sedan',  consumoCidade: 10.0, consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mitsubishi', modelo: 'Pajero TR4',     motor: '2.0 Flex',       categoria: 'SUV',    consumoCidade: 10.5, consumoEstrada: 13.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mitsubishi', modelo: 'Pajero Full',    motor: '3.8 V6',         categoria: 'SUV',    consumoCidade: 7.5,  consumoEstrada: 10.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Mitsubishi', modelo: 'Outlander',      motor: '3.0 V6',         categoria: 'SUV',    consumoCidade: 9.0,  consumoEstrada: 11.5),

  // ═══════════════════════════════════════════════════════════════
  //  HONDA — MODELOS CLÁSSICOS / POPULARES
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda', modelo: 'Civic LXL',           motor: '1.8 Flex',       categoria: 'Sedan',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda', modelo: 'Civic LXS',           motor: '1.8 Flex',       categoria: 'Sedan',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda', modelo: 'Civic EX',            motor: '2.0 Flex',       categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda', modelo: 'Civic Si',            motor: '2.0 Flex',       categoria: 'Sedan',  consumoCidade: 11.0, consumoEstrada: 13.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda', modelo: 'City Sedan',          motor: '1.5 Flex',       categoria: 'Sedan',  consumoCidade: 12.5, consumoEstrada: 15.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda', modelo: 'Pilot',               motor: '3.5 V6',         categoria: 'SUV',    consumoCidade: 8.5,  consumoEstrada: 11.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda', modelo: 'CR-V',                motor: '2.0 Flex',       categoria: 'SUV',    consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Honda', modelo: 'HR-V',                motor: '1.8 Flex',       categoria: 'SUV',    consumoCidade: 12.0, consumoEstrada: 14.5),

  // ═══════════════════════════════════════════════════════════════
  //  TOYOTA — MODELOS CLÁSSICOS / POPULARES
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota', modelo: 'Corolla 1.8',        motor: '1.8 Flex',       categoria: 'Sedan',  consumoCidade: 12.0, consumoEstrada: 14.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota', modelo: 'Fielder',            motor: '1.8 Flex',       categoria: 'Hatch',  consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota', modelo: 'Camry',              motor: '2.5 Flex',       categoria: 'Sedan',  consumoCidade: 11.5, consumoEstrada: 14.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota', modelo: 'Camry Hybrid',       motor: '2.5 Hybrid',     categoria: 'Sedan',  consumoCidade: 17.5, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota', modelo: 'Fortuner',           motor: '2.8 Diesel',     categoria: 'SUV',    consumoCidade: 9.5,  consumoEstrada: 12.5),
  VeiculoConsumo(tipo: 'Carro', marca: 'Toyota', modelo: 'Land Cruiser Prado', motor: '4.0 V6',         categoria: 'SUV',    consumoCidade: 8.0,  consumoEstrada: 10.5),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — HONDA CG / TITAN (série histórica completa)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'CG 125 Titan KS',      motor: '125cc',          categoria: 'Urbana', consumoCidade: 40.0, consumoEstrada: 44.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'CG 125 Titan ES',      motor: '125cc',          categoria: 'Urbana', consumoCidade: 41.0, consumoEstrada: 45.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'CG 150 Titan ESD',     motor: '149cc',          categoria: 'Urbana', consumoCidade: 36.0, consumoEstrada: 40.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'CG 150 Titan KS',      motor: '149cc',          categoria: 'Urbana', consumoCidade: 35.0, consumoEstrada: 39.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'CG 150 Titan Mix',     motor: '149cc Flex',     categoria: 'Urbana', consumoCidade: 37.0, consumoEstrada: 41.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'CG 160 Titan EX',      motor: '162cc',          categoria: 'Urbana', consumoCidade: 41.0, consumoEstrada: 45.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'CG 160 Titan Sport',   motor: '162cc',          categoria: 'Urbana', consumoCidade: 39.0, consumoEstrada: 43.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'Titan 150 ESD',        motor: '149cc',          categoria: 'Urbana', consumoCidade: 36.0, consumoEstrada: 40.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — HONDA (modelos adicionais)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'Dio 110',              motor: '109cc',          categoria: 'Scooter', consumoCidade: 45.0, consumoEstrada: 49.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'Elite 150',            motor: '149cc',          categoria: 'Scooter', consumoCidade: 40.0, consumoEstrada: 44.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'XL 250R Baja',         motor: '249cc',          categoria: 'Trail',   consumoCidade: 26.0, consumoEstrada: 30.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'Falcon NX4 400',       motor: '399cc',          categoria: 'Naked',   consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'CBX 750F',             motor: '747cc',          categoria: 'Naked',   consumoCidade: 14.0, consumoEstrada: 17.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'CBR 600RR',            motor: '599cc',          categoria: 'Esportiva', consumoCidade: 16.0, consumoEstrada: 20.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'XRE 300 Rally',        motor: '292cc',          categoria: 'Trail',   consumoCidade: 27.0, consumoEstrada: 31.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'CRF 300 Rally',        motor: '286cc',          categoria: 'Trail',   consumoCidade: 28.0, consumoEstrada: 33.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'CB 400F',              motor: '399cc',          categoria: 'Naked',   consumoCidade: 24.0, consumoEstrada: 28.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'CB 500X',              motor: '471cc',          categoria: 'Trail',   consumoCidade: 22.0, consumoEstrada: 26.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda', modelo: 'Biz 100',              motor: '99cc',           categoria: 'Urbana',  consumoCidade: 50.0, consumoEstrada: 54.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — YAMAHA (modelos adicionais)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha', modelo: 'Crypton T115',        motor: '113cc',          categoria: 'Urbana',  consumoCidade: 50.0, consumoEstrada: 54.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha', modelo: 'Crypton ED',          motor: '113cc',          categoria: 'Urbana',  consumoCidade: 49.0, consumoEstrada: 53.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha', modelo: 'YBR 250',             motor: '249cc',          categoria: 'Urbana',  consumoCidade: 27.0, consumoEstrada: 31.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha', modelo: 'FZ1',                 motor: '998cc',          categoria: 'Naked',   consumoCidade: 16.0, consumoEstrada: 20.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha', modelo: 'R6',                  motor: '599cc',          categoria: 'Esportiva', consumoCidade: 16.0, consumoEstrada: 20.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha', modelo: 'XJ6',                 motor: '600cc',          categoria: 'Naked',   consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha', modelo: 'Ténéré 700 Explorer', motor: '689cc',          categoria: 'Trail',   consumoCidade: 17.0, consumoEstrada: 21.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha', modelo: 'WR 250R',             motor: '249cc',          categoria: 'Trail',   consumoCidade: 28.0, consumoEstrada: 33.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha', modelo: 'MT-10',               motor: '998cc',          categoria: 'Naked',   consumoCidade: 14.0, consumoEstrada: 18.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — SUZUKI (modelos adicionais)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki', modelo: 'GSX 250R',            motor: '248cc',          categoria: 'Esportiva', consumoCidade: 25.0, consumoEstrada: 29.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki', modelo: 'GSX-R 600',           motor: '599cc',          categoria: 'Esportiva', consumoCidade: 15.0, consumoEstrada: 19.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki', modelo: 'Hayabusa 1340',       motor: '1340cc',         categoria: 'Esportiva', consumoCidade: 12.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki', modelo: 'GS 500',              motor: '487cc',          categoria: 'Naked',   consumoCidade: 21.0, consumoEstrada: 25.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki', modelo: 'DR 650',              motor: '644cc',          categoria: 'Trail',   consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki', modelo: 'V-Strom 250',         motor: '248cc',          categoria: 'Trail',   consumoCidade: 30.0, consumoEstrada: 35.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Suzuki', modelo: 'Address 125',         motor: '124cc',          categoria: 'Scooter', consumoCidade: 42.0, consumoEstrada: 46.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — KAWASAKI (modelos adicionais)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki', modelo: 'Ninja ZX-14R',      motor: '1441cc',         categoria: 'Esportiva', consumoCidade: 12.0, consumoEstrada: 16.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki', modelo: 'Z650 RS',           motor: '649cc',          categoria: 'Naked',   consumoCidade: 19.0, consumoEstrada: 23.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki', modelo: 'KLX 250',           motor: '249cc',          categoria: 'Trail',   consumoCidade: 28.0, consumoEstrada: 33.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki', modelo: 'W800',              motor: '773cc',          categoria: 'Custom',  consumoCidade: 18.0, consumoEstrada: 22.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki', modelo: 'Ninja H2',          motor: '998cc',          categoria: 'Esportiva', consumoCidade: 13.0, consumoEstrada: 17.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kawasaki', modelo: 'Versys 1000',       motor: '1043cc',         categoria: 'Trail',   consumoCidade: 16.0, consumoEstrada: 20.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — KTM (modelos adicionais)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'KTM', modelo: 'Duke 125',               motor: '125cc',          categoria: 'Naked',   consumoCidade: 38.0, consumoEstrada: 43.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'KTM', modelo: '890 Adventure R',        motor: '889cc',          categoria: 'Trail',   consumoCidade: 17.0, consumoEstrada: 21.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'KTM', modelo: '1290 Super Adventure',   motor: '1301cc',         categoria: 'Trail',   consumoCidade: 14.0, consumoEstrada: 18.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'KTM', modelo: 'RC 125',                 motor: '125cc',          categoria: 'Esportiva', consumoCidade: 38.0, consumoEstrada: 43.0),

  // ═══════════════════════════════════════════════════════════════
  //  MOTOS — SCOOTER (adicionais)
  // ═══════════════════════════════════════════════════════════════
  VeiculoConsumo(tipo: 'Moto', marca: 'Honda',   modelo: 'Scoopy 110',         motor: '109cc',          categoria: 'Scooter', consumoCidade: 47.0, consumoEstrada: 51.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',  modelo: 'Fino 125',           motor: '124cc',          categoria: 'Scooter', consumoCidade: 42.0, consumoEstrada: 46.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Kymco',   modelo: 'Like 200i',          motor: '163cc',          categoria: 'Scooter', consumoCidade: 30.0, consumoEstrada: 34.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'SYM',     modelo: 'Jet 14',             motor: '125cc',          categoria: 'Scooter', consumoCidade: 40.0, consumoEstrada: 44.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Shineray', modelo: 'Lince 150',         motor: '149cc',          categoria: 'Scooter', consumoCidade: 36.0, consumoEstrada: 40.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Haojue',  modelo: 'Shineray 150',       motor: '149cc',          categoria: 'Scooter', consumoCidade: 36.0, consumoEstrada: 40.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'Yamaha',  modelo: 'XMAX 250',           motor: '249cc',          categoria: 'Scooter', consumoCidade: 28.0, consumoEstrada: 32.0),
  VeiculoConsumo(tipo: 'Moto', marca: 'BMW',     modelo: 'C 400 X',            motor: '350cc',          categoria: 'Scooter', consumoCidade: 25.0, consumoEstrada: 29.0),
];

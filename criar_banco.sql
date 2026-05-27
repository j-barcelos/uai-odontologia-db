-- Script para criar o banco de dados da Clínica Odontológica da UAI
-- Compatível com MySQL/MariaDB

-- Cria o banco de dados caso ainda não exista
CREATE DATABASE IF NOT EXISTS clinica_odontologica
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- Seleciona o banco recém‑criado
USE clinica_odontologica;

-- ------------------------------------------------------------
-- Tabela: profissionais
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS profissionais (
    profissional_id INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    especialidade VARCHAR(80),
    email         VARCHAR(100),
    telefone      VARCHAR(20),
    criado_em     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

-- Índice para busca rápida por e‑mail de profissional
CREATE INDEX idx_profissional_email ON profissionais(email);

-- ------------------------------------------------------------
-- Tabela: pacientes
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pacientes (
    paciente_id INT AUTO_INCREMENT PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL,
    telefone    VARCHAR(20)  NOT NULL,
    criado_em   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

-- Índice para busca rápida por e‑mail de paciente
CREATE INDEX idx_paciente_email ON pacientes(email);

-- ------------------------------------------------------------
-- Tabela: agendamentos
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS agendamentos (
    agendamento_id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id    INT NOT NULL,
    profissional_id INT,
    data_consulta  DATE NOT NULL,
    hora_consulta  TIME NOT NULL,
    observacao     TEXT,
    criado_em      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_agendamento_paciente
        FOREIGN KEY (paciente_id)
        REFERENCES pacientes(paciente_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_agendamento_profissional
        FOREIGN KEY (profissional_id)
        REFERENCES profissionais(profissional_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

-- Índice composto para buscas rápidas por data e hora da consulta
CREATE INDEX idx_agendamento_data_hora
    ON agendamentos (data_consulta, hora_consulta);

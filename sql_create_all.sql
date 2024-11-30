CREATE TABLE EMITENTI_1 (
    EMITENTA_ID INT PRIMARY KEY,
    NOSAUKUMS VARCHAR(50),
    KREDITA_REITINGS VARCHAR(3)
);

CREATE TABLE OBLIGACIJAS_1 (
    OBLIGACIJAS_ID INT PRIMARY KEY,
    NOMINALA_VERTIBA DECIMAL(10, 2),
    KUPONS DECIMAL(10, 2),
    DZESANAS_DATUMS DATE,
    EMITENTA_ID INT NOT NULL,
    FOREIGN KEY (EMITENTA_ID) REFERENCES EMITENTI_1(EMITENTA_ID)
);

-- RELACIJU AR OBJEKTU DATU BAZES OBJEKTU TABULAS

CREATE OR REPLACE TYPE Emitents AS OBJECT (
    EMITENTA_ID INT,
    NOSAUKUMS VARCHAR2(50),
    KREDITA_REITINGS VARCHAR(3)
);
/
CREATE TABLE EMITENTI_2 OF Emitents (
    PRIMARY KEY (EMITENTA_ID)
);

CREATE OR REPLACE TYPE Obligacija AS OBJECT (
    OBLIGACIJAS_ID INT,
    NOMINALA_VERTIBA DECIMAL(10, 2),
    KUPONS DECIMAL(10, 2),
    DZESANAS_DATUMS DATE,
    EMITENTS_REF REF Emitents,
    
    MEMBER FUNCTION CalculateBondPrice_2 RETURN NUMBER
);
/
CREATE TABLE OBLIGACIJAS_2 OF Obligacija (
    PRIMARY KEY (OBLIGACIJAS_ID),
    SCOPE FOR (EMITENTS_REF) IS EMITENTI_2
);
/

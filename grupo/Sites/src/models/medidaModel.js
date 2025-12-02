var database = require("../database/config");

function buscarUltimasMedidas(fkEmpresa) {

    var instrucaoSql = `SELECT 
    t.idTanque,
    t.nome AS nomeTanque,
    ROUND(AVG(ultimas.temperatura), 2) AS mediaTanque
FROM tanque t
JOIN sensor s ON s.fkTanque = t.idTanque
JOIN (
    SELECT 
        ct1.fkSensor,
        ct1.temperatura
    FROM coletaTemp ct1
    JOIN (
        SELECT fkSensor, MAX(dtHora) AS ultimaData
        FROM coletaTemp
        GROUP BY fkSensor
    ) ult ON ult.fkSensor = ct1.fkSensor AND ult.ultimaData = ct1.dtHora
) ultimas ON ultimas.fkSensor = s.idSensor
WHERE t.fkEmpresa = ${fkEmpresa}
GROUP BY t.idTanque;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idAquario) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                        fk_aquario 
                        FROM medida WHERE fk_aquario = ${idAquario} 
                    ORDER BY id DESC LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}

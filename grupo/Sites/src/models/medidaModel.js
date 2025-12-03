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

function buscarMedidasEmTempoReal(idTanque, fkEmpresa) {
    console.log("TESTE MATHEUS É GAY: " + fkEmpresa)

    var instrucaoSql = `SELECT t.idTanque,
            t.nome AS nometanque,
            t.setor AS setortanque,
            ROUND(AVG(ct.temperatura), 2) AS mediaTanque,
            DATE_FORMAT(MAX(ct.dtHora), '%H:%i') AS ultimaColeta
            FROM tanque t
                JOIN sensor s ON t.idTanque = s.fkTanque
                JOIN coletaTemp ct on s.idSensor = ct.fkSensor
                where fkEmpresa = ${fkEmpresa} and idTanque = ${idTanque}
            GROUP BY idTanque, dtHora 
            order by ultimaColeta DESC limit 7;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}

var database = require("../database/config")

// tanques gerais da empresa
function tanquesEmpresa(fkEmpresa) {
    console.log("ACESSEI O TANQUE MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function tanquesEmpresa(): ", fkEmpresa)

    var instrucaoSql = `
        select t.idTanque,
		    t.nome AS nometanque,
            t.setor AS setortanque,
            t.TempMax AS configMaxTemp,
            t.TempMin AS configMinTemp,
                ROUND(AVG(ct.temperatura), 2) AS mediaTanque,
                MAX(ct.dtHora) AS ultimaColeta
            FROM tanque t
                JOIN sensor s ON t.idTanque = s.fkTanque
                JOIN coletaTemp ct on s.idSensor = ct.fkSensor
            WHERE fkEmpresa = 1 AND dtHora = (select dtHora from coletaTemp JOIN sensor on fkSensor = idSensor WHERE fktanque = t.idTanque order by dtHora DESC limit 1)
            GROUP BY idTanque;
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// estatisticas de um tanque em especifico
function estatisticasTanque(fkEmpresa, fkTanque) {
    console.log("ACESSEI O TANQUE MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function statisticasTanque(): ", fkEmpresa)

    var instrucaoSql = `
        SELECT t.idTanque,
            t.nome AS nometanque,
            t.setor AS setortanque,
            t.TempMax AS configMaxTemp,
            t.TempMin AS configMinTemp,
            ROUND(AVG(ct.temperatura), 2) AS mediaTanque,
            ct.dtHora AS ultimaColeta
            FROM tanque t
                JOIN sensor s ON t.idTanque = s.fkTanque
                JOIN coletaTemp ct on s.idSensor = ct.fkSensor
            WHERE fkEmpresa = ${fkEmpresa} AND idTanque = ${fkTanque}
            GROUP BY idTanque, dtHora;
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql)
}

//  alteração das infos do tanque
function alterarConfigsTanque(idTanque, nomeTanque, max, min, setortanque, fkEmpresa) {
    console.log("ACESSEI O TANQUE MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function alterarConfigsTanque(): ", idTanque, nomeTanque, max, min, setortanque, fkEmpresa)
    var instrucaoSql = `
    UPDATE tanque SET TempMax = ${max}, TempMin = ${min}, nome = '${nomeTanque}', setor = '${setortanque}'
	    WHERE idTanque = ${idTanque} AND fkEmpresa = ${fkEmpresa}
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql)
}


// alerta de temperatura
function alertaTemp(fkEmpresa) {
    console.log("ACESSEI O TANQUE MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function alertaTanque(): ", fkEmpresa)
    instrucaoSql = `
        SELECT idTanque, nomeTanque, setorTanque, mediaTanque FROM vw_alerta_tanque WHERE fkEmpresa = ${fkEmpresa};
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql)
}


function gerarGrafico(fkEmpresa, fkTanque) {
    console.log("ACESSEI O TANQUE MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function statisticasTanque(): ", fkEmpresa)

    var instrucaoSql = `
        SELECT t.idTanque,
            t.nome AS nometanque,
            t.setor AS setortanque,
            ROUND(AVG(ct.temperatura), 2) AS mediaTanque,
            DATE_FORMAT(MAX(ct.dtHora), '%H:%i') AS ultimaColeta
            FROM tanque t
                JOIN sensor s ON t.idTanque = s.fkTanque
                JOIN coletaTemp ct on s.idSensor = ct.fkSensor
                where fkEmpresa = ${fkEmpresa} and idTanque = ${fkTanque}
            GROUP BY idTanque, dtHora 
            order by dtHora DESC limit 7;
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql)
}
module.exports = {
    tanquesEmpresa,
    estatisticasTanque,
    alterarConfigsTanque,
    alertaTemp,
    gerarGrafico
}
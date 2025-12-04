function validarSessao() {
    var nome_user = sessionStorage.NOME_USUARIO
    var fkEmpresa = sessionStorage.FK_EMPRESA
    if (nome_user == undefined || fkEmpresa == undefined) {
        window.location.href = '../login.html'
    } else {
        console.log('Aq')
        var p_nome = document.getElementById('p_NomeUsuario')
        p_nome.innerHTML = nome_user
    }
}
function validarSessaoN3() {
    var nivelSuporte = sessionStorage.NIVEL_SUPORTE
    if (nivelSuporte == undefined) {
        window.location.href = '../login.html'
    }
}
function limparSessao() {
    sessionStorage.clear()
    window.location.href = '../login.html'
}
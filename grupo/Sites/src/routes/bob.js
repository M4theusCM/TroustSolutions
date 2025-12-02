var express = require("express");
var router = express.Router();

var bobControle = require('../controllers/bobController')

router.post("/perguntar", async (req, res) => {
    const pergunta = req.body.pergunta;
    try {
        const resultado = await bobControle.gerarResposta(pergunta);
        res.json({ resultado });
    } catch (error) {
        res.status(500).json({ error: 'Erro interno do servidor' });
    }

});

module.exports = router;

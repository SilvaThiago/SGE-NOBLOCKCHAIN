
app.get("/",function(req,res){

  //const connection = require('./config/dbConnection');

    // aqui vai vir do banco
    const leiloes=[
        {
          "id": 1000,
          "numero_casa":10,
          "picture": "images/01.jpeg",
          "qtd_energica": 200,
          "maior_lance": 500
        },
        {
            "id": 200,
            "numero_casa":12,
            "picture": "images/02.jpeg",
            "qtd_energica": 300,
            "maior_lance": 400
          },
          {
            "id": 300,
            "numero_casa":15,
            "picture": "images/03.jpeg",
            "qtd_energica": 600,
            "maior_lance": 500
          }
      ];

    res.render("./pages/home",{leiloes});
});

app.post("/salvar",(req,res)=>{
    // regrar de salvar
    res.statusCode =201;
    res.send("Lance cadastrado com sucesso!")
});

app.listen(port,()=>{
    console.log(`Leilão rodando na porta ${port}!`);
});
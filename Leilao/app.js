//porta da aplicação
const port = 3000;

const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const session = require("express-session");
const Database = require('./config/dbConnection');
const md5 = require('md5'); 
const util = require('util');
//const bcrypt = require ('bcrypt');
//const salt = bcrypt.genSaltSync(10);


app.set('view engine', 'ejs');
app.use(express.static(__dirname+'/public'));
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});
app.use(session({
  secret:'fahafuehjababdfhageyhafbhafgjagfdygfdha',
  resave: false,
  saveUninitialized: false
}));

app.get("/",async  function(req,res){
   const connection =  new Database();
   if(req.session.autorizado){
        // Atualizando o banco com a energia gerada
        PATH_UPDATER = "/home/thiago/Documentos/Coding/Truffle/desenv-node/Leilao/scripts/update_power.py"
        var exec = require('child_process').exec;

        child = exec('python3 ' + PATH_UPDATER,
          function(error, stdout, stderr) {
            console.log('stdout: ' + stdout);
            console.log('stderr: ' + stderr);
            if (error != null) {
              console.log('exec error: ' + error);
            }
          }
        );
        const casas =await connection.query('select * from leilao.tb_casa');
        const leiloes = await connection.query('select * from leilao.tb_acutions');
        connection.close();
        res.render("./pages/home",
        {
          casas,
          leiloes
        }); 
  }else{
    res.redirect("/login");
  }
});

app.post("/salvar",async (req,res)=>{
    const {id, numero,energia,imagem} = req.body;
    if(energia > 0){
      // const connection = new Database();
      if(req.session.autorizado){
        // preco_inicial = energia*2.5;
        // // console.log(preco_inicial);
        // await connection.query(`insert into leilao.tb_acutions(house_id,house_number,energy,picture,greatest_bid)
        //                   values(${id},${numero},${energia},'${imagem}',${preco_inicial})`);
        // connection.query(`UPDATE leilao.tb_casa SET saldo_energetico=0 WHERE id=${id}`);
        res.statusCode =201;
        // connection.close();
        res.send("Leilão cadastrado com sucesso!");
      } 
      else{
        res.redirect("/login");
      }   
    }else{
      res.send("Você não tem saldo energético suficiente para leiloar!")
    }
  });

  app.get("/login",  function(req,res){ 
    res.render("./pages/login");
});

app.post("/autenticar",async (req,res)=>{
  let {username,password} = req.body;
  const connection = new Database();
  const usuario =  await connection.query(`select * from leilao.tb_usuario where nome ='${username}'`);
  if((usuario[0]!= undefined) && (usuario[0].senha == md5(password))){
    req.session.autorizado = true;
    req.session.usuario = {
                            'id' : usuario[0].id, 
                            'nome':usuario[0].nome 
                          };
    res.redirect('/');
  }else{
        console.log(md5(password));
        res.redirect("./login");
      } 
  connection.close();    
});

app.post("/lancamento",async (req,res)=>{
    const {id} = req.body;
    const connection = new Database();
    
    if(req.session.autorizado){
        const user_id =req.session.usuario.id;
        const leilao = await connection.query(`select * from leilao.tb_acutions where id =${id}`);
        const greatest_bid = parseInt(leilao[0].greatest_bid + 10);

        await connection.query(`update leilao.tb_acutions set user_id=${user_id}, greatest_bid=${greatest_bid} where id=${id}`);
        res.statusCode =200;
        res.send("Leilão cadastrado com sucesso!");
  } 
  else{
    res.redirect("/login");
  }
  connection.close(); 
});


  
  app.listen(port,()=>{
      console.log(`Leilão rodando na porta ${port}!`);
  });
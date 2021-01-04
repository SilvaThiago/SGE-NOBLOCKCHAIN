const request = require('request');
const url = "http://localhost:3000"

const form={
    username : 'teste',
    password :'123' 
}

var headers = {
    'content-type': 'application/json',
    'accept': 'application/json'
};

let cookie='';
 async function autenticar(){
     return new Promise((resolve,reject)=>{
    
        request.post({url: `${url}/autenticar`, body: JSON.stringify(form), headers: {'content-type': 'application/json',
            'accept': 'application/json'
            }
            }, function(err, res, body){
                // if(err) console.log('login error');
            
                var setCookie = res.headers['set-cookie'];
                cookie = setCookie[0].split('=')[1].split(' ')[0];
                // console.log('login success');
                return resolve(cookie);
            });
        });        
 }

 salvar_casa = async (cookie,casa)=>{
        return new Promise((resolve,reject)=>{
            request.post({url: `${url}/salvar`, body: JSON.stringify(casa), headers: {
                'content-type': 'application/json',
                'accept': 'application/json',
                'Cookie': `connect.sid=${cookie}`
            }
                                }, function(err, res, body){
                                    const status = res ? res.statusCode : 0;
                                    resolve(status);
                    });        
        });
 }

 dar_lance = async (cookie,id)=>{
    return new Promise((resolve,reject)=>{
        request.post({url: `${url}/lancamento`, body: JSON.stringify({id}), headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
            'Cookie': `connect.sid=${cookie}`
        }
                            }, function(err, res, body){
                                const status = res ? res.statusCode : 0;
                                resolve(status);
                });        
    });
}

_run = async () =>{
    // console.log('rodando cliente request!');  
    let cookie=  await autenticar().then(res=>res);
    let i =0;
    var duracao_total = 0;
    while(i < 100){
        let casa = { 
                    id: 1,
                    numero: 10,
                    energia: 200,
                    imagem:'images/01.jpeg'
                    };
        var antes = Date.now();
        let st = await salvar_casa(cookie,casa);
        duracao_total += Date.now() - antes;
        // if(st && st ==201) console.log('Leiloou a casa de id: '+casa.id);
        i++;
    }
    console.log(duracao_total);
    // console.log('fim da execução do cliente!')
}


 _run();
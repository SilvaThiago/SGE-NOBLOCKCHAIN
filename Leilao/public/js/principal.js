async function salvar(id,numero,energia,imagem){
     await fetch('http://localhost:3000/salvar', { 
        method: 'post',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
        body: JSON.stringify({
            id,numero,energia,imagem
          }) 
     })
    .then((response) =>{ 
    alert('dados atualizados com sucesso!')
    window.location.reload();
    }).catch(function(err) { console.error(err); });
}


async function dar_lance(id){
     await fetch('http://localhost:3000/lancamento', { 
      method: 'post',
      headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      body: JSON.stringify({
          id
        }) 
   })
  .then(function(response) { 
  alert('dados atualizados com sucesso!')
  window.location.reload();
  }).catch(function(err) { console.error(err); });
}
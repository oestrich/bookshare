// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

document.observe("dom:loaded", function() {  
  $('filter').observe('keyup',function(ev){
    if (ev.srcElement.value) {
      $$('p.title').each(function(v,i){
        if (new RegExp('.*'+ev.srcElement.value,'ig').test(v.innerHTML)){
          v.up().up().show();
        }else{
          v.up().up().hide();
        }
      });
    }else{
      $$('div.book_wrapper').each(function(v,i){
        v.show();
      });
    }
  });
});

function clear_filter(){
  document.getElementById('filter').value = '';

  $$('div.book_wrapper').each(function(v,i){
    v.show();
  });
}

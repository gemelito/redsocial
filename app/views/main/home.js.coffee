#Para obtener los posts y pasarlo al home.haml
#Pregunta que al menos haiga una pagina Quitala
$("#posts .data").append("<%= j render @posts %>")
$("#pagination").html("<%= j will_paginate @posts %>")
<% unless @posts.next_page %>
$("#pagination").remove()
<%end%>
window.loading = false
const resgisterClient = document.querySelector('#formCliente')//id correcto
resgisterClient.addEventListener('submit', async e => {
    e.preventDefault();
    const id_cliente = e.target.id_cliente.value;
    const nombre = e.target.nombre.value;
    const primer_apellido = e.target.primer_apellido.value;
    const segundo_apellido = e.target.segundo_apellido.value;
    const telefono_1 = e.target.telefono_1.value;
    const telefono_2 = e.target.telefono_2.value;

    try {
        const {data} = await axios.post('api/v1/clientes/cliente', {
            id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email
        })
    } catch (error) {
        if (error.response) {
            // El servidor respondió con un código de estado fuera del rango 2xx
            console.error('Error de respuesta del servidor:', error.response.data);
            console.error('Código de estado:', error.response.status);
            console.error('Encabezados:', error.response.headers);
            
            // Personaliza un mensaje para el usuario
            alert(`Error al crear el cliente: ${error.response.data.message || 'Error desconocido del servidor'}`);
        } else if (error.request) {
            // La solicitud fue realizada pero no se recibió respuesta
            console.error('No se recibió respuesta del servidor:', error.request);
            alert('Error al conectar con el servidor, por favor intente más tarde.');
        } else {
            // Algo ocurrió al configurar la solicitud
            console.error('Error al configurar la solicitud:', error.message);
            alert('Hubo un problema al procesar la solicitud, por favor intente de nuevo.');
        }
    }

})


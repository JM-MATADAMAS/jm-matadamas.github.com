<template>
    <v-container>
        <v-app-bar app color="primary" dark>
            <v-toolbar-title :style="{ fontFamily: 'Courier New', fontSize: '30px', fontWeight: 'bold' }">Coros</v-toolbar-title>
            <v-spacer/><v-spacer/>
            <v-toolbar-title :style="{ fontFamily: 'Courier New', fontSize: '30px', fontWeight: 'bold' }">SH</v-toolbar-title>
        </v-app-bar>
        <!-- Tabla de Misas -->
        <v-data-table :headers="encabezados" :items="misas" :items-per-page="15" :class="elevation-1">
            <template v-slot:top>
                <v-toolbar flat>
                    <v-toolbar-title :style="{ fontFamily: 'Courier New', fontSize: '30px', fontWeight: 'bold' }">Misas</v-toolbar-title>
                    <v-spacer/>
                    <v-spacer/>
                    <v-btn color="primary" @click="mostrarDialogoAgregarMisa">Agregar Misa</v-btn>
                </v-toolbar>
            </template>
            <template v-slot:item.actions="{ item }">
                <v-icon @click="eliminar_misa(item)" small class="mr-5">
                    fa-solid fa-trash
                </v-icon>
                <v-icon @click="editarMisa(item)" small class="mr-5">
                    fa-solid fa-pencil-alt
                </v-icon>
                <v-icon @click="verDetalles(item)" small>
                    mdi-eye
                </v-icon>
            </template>
        </v-data-table>
        <v-dialog v-model="nm_dialog" max-width="500px">
            <v-card>
                <v-card-title>
                    {{ nueva_misa.mi_id ? 'Editar Misa' : 'Nueva Misa' }}
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-date-picker v-model="nueva_misa.mi_fecha" label="Fecha"></v-date-picker>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="12"     align-self="auto">
                                <v-select v-model="nueva_misa.mi_tipo" :items="tipo" label="Tipo"></v-select>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="6">
                                <v-select v-model="nueva_misa.mi_entrada" :items="entrada" label="Entrada"></v-select>
                            </v-col>
                            <v-col cols="6">
                                <v-select v-model="nueva_misa.mi_piedad" :items="piedad" label="Piedad"></v-select>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="6">
                                <v-select v-model="nueva_misa.mi_gloria" :items="gloria" label="Gloria"></v-select>
                            </v-col>
                            <v-col cols="6">
                                <v-select v-model="nueva_misa.mi_salmo" :items="salmo" label="Salmo"></v-select>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="6">
                                <v-select v-model="nueva_misa.mi_aleluya" :items="aleluya" label="Aleluya"></v-select>
                            </v-col>
                            <v-col cols="6">
                                <v-select v-model="nueva_misa.mi_ofertorio" :items="ofertorio" label="Ofertorio"></v-select>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="6">
                                <v-select v-model="nueva_misa.mi_santo" :items="santo" label="Santo"></v-select>
                            </v-col>
                            <v-col cols="6">
                                <v-select v-model="nueva_misa.mi_cordero" :items="cordero" label="Cordero"></v-select>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="6">
                                <v-select v-model="nueva_misa.mi_comunion" :items="comunion" label="Comunión"></v-select>
                            </v-col>
                            <v-col cols="6">
                                <v-select v-model="nueva_misa.mi_salida" :items="salida" label="Salida"></v-select>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="12">
                                <v-text-field v-model="nueva_misa.mi_comentario" rows="5" Multi-line label="Comentario"></v-text-field>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="guardar_misa()">Guardar</v-btn>
                      <v-btn color="error" @click="cancelar()">Cancelar</v-btn>
                  </v-card-actions>
              </v-card>
        </v-dialog>
      <v-dialog v-model="d_dialog" max-width="500px">
        <v-card>
            <v-card-title>Cantos de la misa</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row v-for="(item, index) in misas" :key="index">
                            <v-col cols="12">
                                <v-text-field label="Entrada" v-model="item.mi_entrada" disabled></v-text-field>
                                <v-text-field label="Piedad" v-model="item.mi_piedad" disabled></v-text-field>
                                <v-text-field label="Gloria" v-model="item.mi_gloria" disabled></v-text-field>
                                <v-text-field label="Salmo" v-model="item.mi_salmo" disabled></v-text-field>
                                <v-text-field label="Aleluya/Honor y gloria" v-model="item.mi_aleluya" disabled></v-text-field>
                                <v-text-field label="Ofertorio" v-model="item.mi_ofertorio" disabled></v-text-field>
                                <v-text-field label="Santo" v-model="item.mi_santo" disabled></v-text-field>
                                <v-text-field label="Cordero" v-model="item.mi_cordero" disabled></v-text-field>
                                <v-text-field label="Comunion" v-model="item.mi_comunion" disabled></v-text-field>
                                <v-text-field label="Salida" v-model="item.mi_salida" disabled></v-text-field>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="error" @click="cancelar()">Salir</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <v-dialog v-model="mostrarDialogo" max-width="500px">
            <v-card>
                <v-card-title>Agregar Misa</v-card-title>
                    <v-card-text>
                        <v-container>
                            <v-row>
                                <v-col cols="6">
                                    <v-menu
                                        v-model="fechaPickerVisible"
                                        :close-on-content-click="false"
                                        transition="scale-transition"
                                        offset-y
                                    >
                                        <template v-slot:activator="{ on }">
                                            <v-text-field
                                                v-model="nueva_misa.mi_fecha"
                                                label="Fecha"
                                                readonly
                                                v-on="on"
                                            ></v-text-field>
                                        </template>
                                        <v-date-picker v-model="nueva_misa.mi_fecha"></v-date-picker>
                                    </v-menu>
                                </v-col>
                                <v-col cols="6">
                                    <v-select v-model="nueva_misa.mi_tipo" :items="tipo" label="Tipo"></v-select>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="6">
                                    <v-select v-model="nueva_misa.mi_entrada" :items="entrada" label="Entrada"></v-select>
                                </v-col>
                                <v-col cols="6">
                                    <v-select v-model="nueva_misa.mi_piedad" :items="piedad" label="Piedad"></v-select>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="6">
                                    <v-select v-model="nueva_misa.mi_gloria" :items="gloria" label="Gloria"></v-select>
                                </v-col>
                                <v-col cols="6">
                                    <v-select v-model="nueva_misa.mi_salmo" :items="salmo" label="Salmo"></v-select>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="6">
                                    <v-select v-model="nueva_misa.mi_aleluya" :items="aleluya" label="Aleluya"></v-select>
                                </v-col>
                                <v-col cols="6">
                                    <v-select v-model="nueva_misa.mi_ofertorio" :items="ofertorio" label="Ofertorio"></v-select>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="6">
                                    <v-select v-model="nueva_misa.mi_santo" :items="santo" label="Santo"></v-select>
                                </v-col>
                                <v-col cols="6">
                                    <v-select v-model="nueva_misa.mi_cordero" :items="cordero" label="Cordero"></v-select>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="6">
                                    <v-select v-model="nueva_misa.mi_comunion" :items="comunion" label="Comunión"></v-select>
                                </v-col>
                                <v-col cols="6">
                                    <v-select v-model="nueva_misa.mi_salida" :items="salida" label="Salida"></v-select>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="12">
                                    <v-text-field v-model="nueva_misa.mi_comentario" rows="5" Multi-line label="Comentario"></v-text-field>
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="guardarNuevaMisa">Guardar</v-btn>
                    <v-btn color="error" @click="mostrarDialogo = false">Cancelar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-container>
</template>

  
<script>
export default {
    name: 'admin',

    data() {
        return {
            
            // Encabezados Usuarios
            encabezados: [
                {text: 'Fecha',value: 'mi_fecha'},
                {text: 'Tipo',value: 'mi_tipo'},
                {text: 'Acciones', sortable: false,value: 'actions'}
            ],

            misas: [],

            nm_dialog: false,
            d_dialog:false,
            fechaPickerVisible: false,
            mostrarDialogo: false,

            nueva_misa: {
                mi_fecha: '',
                mi_tipo: '',
                mi_entrada: '',
                mi_piedad: '',
                mi_gloria: '',
                mi_salmo: '',
                mi_aleluya: '',
                mi_ofertorio: '',
                mi_santo: '',
                mi_cordero: '',
                mi_comunion: '',
                mi_salida: '',
                mi_comentario: '',
            },

            nuevaMisa: {
                mi_fecha: '',
                mi_tipo: '',
                mi_entrada: '',
                mi_piedad: '',
                mi_gloria: '',
                mi_salmo: '',
                mi_aleluya: '',
                mi_ofertorio: '',
                mi_santo: '',
                mi_cordero: '',
                mi_comunion: '',
                mi_salida: '',
                mi_comentario: '',
            },

            misasSeleccionadas: [], 

            elevation: 'elevation-1',
            
            tipo:['Ordinario', 'Contrato', 'XV años', 'Boda', 'Bautizo', 'Oficio', 'Otro'],

            entrada:['Venimos hoy a tu altar', 'Vienen con alegría', 'Den al señor sus alabanzas', 'Aquí estoy señor', 
						'Al fin', 'Quince años', 'Que alegría cuando me dijeron', 'Tú eres fiel', 'Que viva mi cristo', 
						'En torno a tu altar', '*No hay*', '*No aplica*'],

            piedad:['Popular', 'Triste', 'Brandon', 'Rocker', '*No hay*', '*No aplica*'],

            gloria:['90', 'Mejía', 'Rítmico', 'Panamericano', 'Popular', '*No hay*', '*No aplica*'],

            salmo: ['Lento', 'Rapido', 'Otro ritmo', '*No hay*', '*No aplica*'],

            aleluya:['Solemne', 'Al salvador', 'Popular', 'Karla', 'Javi', 'Ángel', 'Honor y gloria', 
						'Honor y gloria alternativo', '*No hay*', '*No aplica*'],
            ofertorio:['Vino y pan', 'Este pan y vino', 'Esto que te doy', 'Te ofrezco, señor, mi juventud',
						'Tómalo, acéptalo', 'Nuestro corazón', 'Te presentamos', 'En tus manos', '*No hay*', '*No aplica*'],
            
            santo:['La-Mi-Do', 'Edith', 'Gabi', 'Rondalla', '3 Hosanas', 'Hosana', 'Choco', '*No hay*', '*No aplica*'],

            cordero: ['Popular', 'Juvenil', 'Choco', '94', 'Roy', 'Marcha', 'Doble', '*No hay*', '*No aplica*'],

            comunion: ['El vino', 'Llévame', 'La promesa', 'Abba padre', 'Una espiga', 'Andando de tu mano, Dios está aqui',
						'Las heridas de tu frente', 'Un instrumento de tu amor', 'Ven señor Jesus', 'Un día caminaba', 'Heroe',
						'Dialogo con Cristo', '*No hay*', '*No aplica*'],
            
            salida:['Alma misionera', 'Te doy gracias Jesus', 'Dios es amor', 'Cristo no defrauda', 'Fragmento a Dios',
						 'Viva cristo rey', '*No hay*', '*No aplica*']
        };
    },

    created() {
        this.llenar_misas();
    },

    methods: {
        async llenar_misas() {
            const api_data = await this.axios.get('/misa/misa_base/');
            this.misas = api_data.data.map((misa) => ({
                ...misa,
            }));
        },

        async eliminar_misa(item) {
            const body = {
                mi_id: item.mi_id,
            };
            await this.axios.delete('misa/eliminar_misa', {
                data: body
            });
            this.llenar_misas();
        },

        cancelar() {
            this.nueva_misa = {
                mi_fecha: '',
                mi_tipo: '',
                mi_entrada: '',
                mi_piedad: '',
                mi_gloria: '',
                mi_salmo: '',
                mi_aleluya: '',
                mi_ofertorio: '',
                mi_santo: '',
                mi_cordero: '',
                mi_comunion: '',
                mi_salida: '',
                mi_comentario: '',
            };
            this.d_dialog = false;
            this.nm_dialog = false;
            this.mostrarDialogo= false;
            this.llenar_misas();
        },

        async guardar_misa() {
    if (this.nueva_misa.mi_id) {
      await this.axios
        .put(`/misa/editar_misa/${this.nueva_misa.mi_id}`, this.nueva_misa)
        .then((response) => {
          console.log(response.data); // Opcional: muestra la respuesta del servidor si es necesario
          this.llenar_misas();
          this.cancelar();
        })
        .catch((error) => {
          console.error(error);
        });
    } else {
      console.error("ID de misa no definido.");
    }
  },

        editarMisa(item) {
            this.nueva_misa = {
                mi_id: item.mi_id,
                mi_fecha: item.mi_fecha,
                mi_tipo: item.mi_tipo,
                mi_entrada: item.mi_entrada,
                mi_piedad: item.mi_piedad,
                mi_gloria: item.mi_gloria,
                mi_salmo: item.mi_salmo,
                mi_aleluya: item.mi_aleluya,
                mi_ofertorio: item.mi_ofertorio,
                mi_santo: item.mi_santo,
                mi_cordero: item.mi_cordero,
                mi_comunion: item.mi_comunion,
                mi_salida: item.mi_salida,
                mi_comentario: item.mi_comentario,
            };
            this.nm_dialog = true;
        },


async verDetalles(item) {
  const mi_id = item.mi_id;
  const api_data = await this.axios.get(`/misa/misa_base/${mi_id}`);
  const detallesMisa = api_data.data;

  this.misas = []; // Vaciar el arreglo de misas
  this.misas.push(detallesMisa); // Agregar los detalles de la misa actual al arreglo

  this.d_dialog = true;
},


        mostrarDialogoAgregarMisa() {
            this.mostrarDialogo = true;
            this.nuevaMisa = {
                mi_fecha: '',
                mi_tipo: '',
                mi_entrada: '',
                mi_piedad: '',
                mi_gloria: '',
                mi_salmo: '',
                mi_aleluya: '',
                mi_ofertorio: '',
                mi_santo: '',
                mi_cordero: '',
                mi_comunion: '',
                mi_salida: '',
                mi_comentario: '',
            };
        },

        guardarNuevaMisa() {
        // Realizar acciones para guardar la nueva misa
        // Puedes acceder a los datos de la nueva misa a través de this.nuevaMisa
        // Por ejemplo, puedes enviar los datos al backend utilizando Axios

        // Ejemplo de envío de datos utilizando Axios:
        this.axios
        .post('/misa/nueva_misa', this.nueva_misa)
        .then(() => {
            // Procesar respuesta exitosa (si es necesario)
            this.llenar_misas(); // Actualizar la lista de misas
            this.cancelar(); // Cerrar el diálogo
        })
        .catch((error) => {
            // Procesar error (si es necesario)
            console.error(error);
        });
        },
    }
};
</script>

<style>
  .centered-title {
    text-align: center;
    margin: auto;
  }
</style>
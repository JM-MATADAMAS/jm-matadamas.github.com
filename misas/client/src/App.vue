<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
    <v-toolbar-title>misas</v-toolbar-title>
    </v-app-bar>

    <v-main>
      <router-view/>
    </v-main>
  </v-app>
</template>

<script>
import router from './router';


export default {
    name: "App",
    data: () => ({
    //
    }),
    components: { router }
};
</script>

<style>
#app {
  background: url('../../mario.gif')
    no-repeat center center fixed !important;
  background-size: cover;
}
</style>
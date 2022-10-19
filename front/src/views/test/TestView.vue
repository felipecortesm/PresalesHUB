<template>
    <div class="about">
        <v-row justify="center" style="padding-bottom: 20px">
            <h1>{{ apiUrl }}</h1>
        </v-row>

        <test-component></test-component>

    </div>
</template>

<script>
    import TestComponent from "@/components/test/TestComponent";
    export default {
        name: 'TestView',
        components: {TestComponent},
        data() {
            return {
                apiUrl: process.env.VUE_APP_ROOT_API,
            };
        },
        methods: {
        }
    }
</script>

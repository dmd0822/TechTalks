import http from "k6/http";
import { sleep } from "k6";

export default function () {

    let params = {
        redirects: 5,
        tags: { "KPI_Get": "yes" }
    };


    let uri = `http://${__ENV.API_HOSTNAME}/api/People`;
    let result = http.get(uri, params);
    
    sleep(1);
};
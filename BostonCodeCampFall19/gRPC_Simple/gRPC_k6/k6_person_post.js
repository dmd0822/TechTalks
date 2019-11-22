import http from "k6/http";
import { check } from "k6";
import { Rate } from "k6/metrics";

export let errorRate = new Rate("errors");

export let options = {
    thresholds: {
        "errors": ["rate==0.0"],
    },
    setupTimeout: "60s"
};

export function setup() {
    //Do something like get auth token 
    let p = 
        {
            "FirstName": "Joe",
            "LastName": "Smith",
            "Age": 44
        };

    return { person: p };
}

export default function (data) {

    let params = {
        redirects: 5,
        headers: {
            'Content-Type': 'application/json',
        },
        tags: { "KPI_post": "yes" }
    };
    console.log(JSON.stringify(data.person));
    let uri = `http://${__ENV.API_HOSTNAME}/api/People`;
    let result = http.post(uri, JSON.stringify(data.person), params);

    console.log(result.status);

    check(result, {
        "is status 200": (r) => r.status === 200,
        "is server IIS": (r) => r.headers['Server'] === 'Microsoft-IIS/10.0'
    }) || errorRate.add(1);
};

export function teardown(data){
    // let params = {
    //     redirects: 5,
    //     tags: { "KPI_delete": "yes" }
    // };

    // let uri = `http://${__ENV.API_HOSTNAME}/api/People`;
    // let result = http.delete(uri, data.person, params);
}
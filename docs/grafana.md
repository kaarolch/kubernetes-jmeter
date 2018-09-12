# Grafana extra information

## Grafana password
Custom password could be sent via grafana charts values:
```
grafana:
  adminUser: admin
  adminPassword: admin12345

```

Or random password could be access via kubectl:
```
kubectl get secrets HELM_RELEASE_NAME-grafana -o 'go-template={{index .data "admin-password"}}' | base64 -d
```
## Expose it via ingress

Currently Grafana allow you to expose ingress via helm charts. Below code need to be added in Grafan config section to the values.yaml:

```
grafana
  ingress:
    enabled: true
    path: /
    hosts:
      - grafan-jmeter.example.com
```

## Access grafana via port-forwarding

```
kubectl port-forward service/HELM_RELEASE_NAME-grafana 30080:80

```
`HEAL_RELEASE_NAME` was provided during stack deploy ( helm `-n` option). Grafana should be enabled via [localhost url](http://localhost:30080)

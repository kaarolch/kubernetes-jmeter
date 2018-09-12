[![License](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)](https://opensource.org/licenses/MIT)
# kubernetes-jmeter

Jmeter test workload inside kubernetes. [Jmeter](charts/jmeter) chart bootstraps an Jmeter stack on a Kubernetes cluster using the Helm package manager.

Currently [jmeter](charts/jmeter) helm chart deploy:
*   Jmeter master
*   Jmeter slaves
*   InfluxDB instance with graphite interface as a jmeter backend
*   Grafana instance


## Installation
```
git clone git@github.com:kaarolch/kubernetes-jmeter.git
cd kubernetes-jmeter/charts/jmeter
helm install --namespace YOUR_NAMESPACE install -n test ./
```
If you would like to provide custom values.yaml you can add `-f` flag.

```
helm install install -n test ./ -f my_values.yaml
```

The command deploys Jmeter on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

If you change deployment name (`-n test`) please update grafana datasource influx `url` inside your custom values.yaml files.

If you already own grafan and influx stack, kuberentes-jmeter could be deployed without those two dependencies.

```
helm install install -n test ./ --set grafana.enabled=false,influxdb.enabled=false
```

## Run sample test

### Manual run
Copy example test

```
kubectl cp examples/simple_test.jmx $(kubectl get pod -l "app=jmeter-master" -o jsonpath='{.items[0].metadata.name}'):/test/

```
Run tests

```
kubectl exec  -it $(kubectl get pod -l "app=jmeter-master" -o jsonpath='{.items[0].metadata.name}') -- sh -c 'ONE_SHOT=true; /run-test.sh'
```

### Run test via configmap

TBD

## Remove stack

```
helm delete YOUR_RELEASE_NAME --purge
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The default configuration values for this chart are listed in [values.yaml](charts/jmeter/values.yaml).

| Parameter                       | Description                                   | Default                  |
|---------------------------------|-----------------------------------------------|--------------------------|
| `imageCredentials.registry`     | Image repository                              | `docker.com`             |
| `imageCredentials.username`     | Repository user                               | -                        |
| `imageCredentials.password`     | Repository password                           | -                        |
| `image.master.repository`       | Image master repository                       | `kaarol/jmeter-master`   |
| `image.master.tag`              | Image master tag.                             | `test`                   |
| `image.master.pullPolicy`       | Image master pull policy                      | `Always`                 |
| `image.slave.repository`        | Image master repository                       | `kaarol/jmeter-slave`    |
| `image.slave.tag`               | Image master tag.                             | `latest`                 |
| `image.slave.pullPolicy`        | Image master pull policy                      | `Always`                 |
| `config.disableSSL`             | Disable SSL communication between node        | `true`                   |
| `config.master.replicaCount`    | Number of master                              | `1` - currently only one |
| `config.master.restartPolicy`   | Pod restart policy                            | `Always`                 |
| `config.master.oneShotTest`     | Run test after successful deployment          | `flase`                  |
| `image.slave.replicaCount`      | Number of jmeter workers                      | `2`                      |
| `image.slave.restartPolicy`     | Pod restart policy                            | `Always`                 |
| `anotations`                    | Additional annotations                        | `{}`                     |
| `labels`                        | Additional labels                             | `{}`                     |

### Grafana tips
File [grafana.md](docs/grafana.md) would cover all extra tips for config/access grafana charts.

## Project status

Currently kubernetes-jmeter project is able to run some test on distributed slaves but there still is a lot to do. In few days there should be some documentation added to this repo.

## To Do
Everything ;)
1.  Visualization stack (Grafana + influxdb)
*   Add default dashboard after deployment
2.  Helm charts - 80% of base chart
*   Auto update influxdb datasource base on release name currently there is fixed test-influx host added.
*   Resource limitation
3.  Jmeter test get from maven (0%)
4.  Jmeter test get from git (20%) - still not push to master
5.  SSL between Jmeter nodes
6.  Documentation (55%)
7.  Release of a helm charts and helm repo update process via travis

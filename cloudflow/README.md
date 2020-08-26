# Cloudflow 

Cloudflow enables you to quickly develop, orchestrate, and operate distributed streaming applications on Kubernetes. With Cloudflow, streaming applications are comprised of small composable components wired together with schema-based contracts. Cloudflow can dramatically accelerate streaming application development—​reducing the time required to create, package, and deploy—​from weeks to hours.

More information about Cloudflow can be found here:
- https://cloudflow.io
- https://www.lightbend.com/cloudflow-by-lightbend

## Prerequisites

- Helm, version 3 or higher.

For evaluation purposes, we recommend using the Strimzi Kafka operator. If Strimzi is used, Cloudflow can create Kafka topics automatically.

https://strimzi.io

For external Kafka clusters, you will have to create the application topics before deploying the application.

## Installing

Execute the following commands to install Cloudflow:

```
$ helm repo add cloudflow-helm-charts https://github.com/lightbend/cloudflow-helm-charts 
$ helm repo update
$ kubectl create ns cloudflow
$ helm install cloudflow-helm-charts/cloudflow --namespace cloudflow --name cloudflow --set key=value[,key=value]
```

>NOTE! You will need to customize the Helm chart configuration values. Please refer to the `Configuration` chapter below for details on this.

## Configuration

The chart can be customized using the following configurable parameters:

| Parameter                       | Description                                                     | Default                      |
| ------------------------------- | ----------------------------------------------------------------| -----------------------------|
| `cloudflow_operator.persistentStorageClass` | The name of the storage class for workloads requiring ReadWriteMany persistent volumes. Examples of these workloads are Spark and Flink checkpointing and savepointing. This must be a `ReadWriteMany` storage class. | ""  |
| `cloudflow_operator.kafkaBootstrapservers` | A comma-separated list of host/port pairs to use for establishing the connection to the Kafka cluster that Cloudflow will use. | ""  |

Specify parameters using `--set key=value[,key=value]` argument to `helm install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

    helm install --name cloudflow -f values.yaml lightbend/cloudflow

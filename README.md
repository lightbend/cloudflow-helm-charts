# Cloudflow 

Cloudflow enables you to quickly develop, orchestrate, and operate distributed streaming applications on Kubernetes. With Cloudflow, streaming applications are comprised of small composable components wired together with schema-based contracts. Cloudflow can dramatically accelerate streaming application development—​reducing the time required to create, package, and deploy—​from weeks to hours.

More information about Cloudflow can be found here:
https://www.lightbend.com/cloudflow-by-lightbend

## Pre-requisites

- Helm, version 3 or higher.
- Kafka cluster

For evaluation purposes, we recommend using the Strimzi Kafka operator. If Strimzi is used, Cloudflow can create Kafka topics automatically.

https://strimzi.io

For external Kafka clusters, the user will have to create the application topics themselves before deploying the application.

## Installing

Currently, this Helm chart is not published in a Helm repository, so in order to install it, you first have to clone this git repository and execute the following commands from the root for the git repository:

    kubectl create ns cloudflow
    helm install . --namespace cloudflow --name cloudflow --set key=value[,key=value]

>NOTE! You will need to customize the Helm chart configuration values. Please refer to the `Cofiguration` chapter below for details on this.

## Configuration

The chart can be customized using the following configurable parameters:

| Parameter                       | Description                                                     | Default                      |
| ------------------------------- | ----------------------------------------------------------------| -----------------------------|
| `cloudflow_operator.persistentStorageClass` | The name of the storage class of the per application PVC created by the Cloudflow operator when deploying an applicaton  brokers and Zookeeper nodes. This should be a `ReadWriteMany` storage class. | ""  |
| `strimzi.enabled`| Enables the use of the Strimzi                                  | false  |
| `strimzi.persistentStorageClass` | The name of the storage class to be used by Kafka brokers and Zookeeper nodes. This should be a `ReadWriteOnce` storage class.                                   | ""  |
| `strimzi.topicOperatorNamespace` | The namespace where the Strimzi topic operator is installed. | "cloudflow"  |

Specify parameters using `--set key=value[,key=value]` argument to `helm install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

    helm install --name cloudflow -f values.yaml lightbend/cloudflow

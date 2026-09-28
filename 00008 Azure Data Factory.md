## Pipeline

    A Pipeline controls the flow of tasks.
    Tasks are performed using activities.
    A pipeline can have one to many activities.
    These activities can be chained in serial or parallel depending on requirements.

## Activity

    Activities executes a task.
    Activities are broadly classified into three types.
        Data movement activities
        Data transformation activities
        Control activities
    Series, parallel and combination
    There is an activity for each task.
    Different activities include copy data, if, for each(loop), set variable, etc.

## Dataset

    Dataset is a pointer or reference to the application from where you need to extract or push the data.
    Depending on the service/application is has configurations which need to be set.
    When you create a dataset , ADF provides 90+ connectors which seamlessly help to connect to top services or applications.

## Linked Service

    Linked service establishes connection to a service or application from where you need to extract or push the data.
    This is an authentication entity which performs the handshake between the data factory and source/target service or application.
    Linked services are consumed in datasets

## Integration Runtime

    Integration Runtime a.k.a IR is the compute infrastructure needed to execute the pipelines in ADF.

{% extends "base.tpl" %}

{% block title %}Index{% endblock %}

{% block pageName %}POS Monitor{% endblock %}

{% block content %}
    {% if loggedIN > 0 %}
    <script type="text/javascript">
    $(document).ready(function(){
        $(".table a").popover({
            placement : 'top',
            html : 'true'
        });
    });
    </script>

    {% if showAnchored == 'old' %}
        <form action='index.php' method='post' align='right'><button type=submit class="btn btn-default">Hide Anchored POSes</button></form>
    {% else %}
        <form action='index.php' method='post' align='right'><input type=hidden name='anchored' value='old'><button type=submit class="btn btn-default">Show Anchored POSes</button></form></form>
    {% endif %}
    <hr>
    {% for corp in data %}
        <div class="panel panel-default">
            <!-- Default panel contents -->
            <div class="panel-heading">
                <h5>Owner: <b>{{ corp.corpName }}</b></h5>
            </div>
             <!-- Table -->
            <table class="table table-striped table-bordered table-hover">
                <thead><tr>
                    <th width="10%">System:</th>
                    <th width="20%">Type:</th>
                    <th width="15%">Moon:</th>
                    <th width="10%">State:</th>
                    <th width="15%">Fuel left<br>(Days and hours):</th>
                    <th width="15%">Stront time left<br>(reinforce timer):</th>
                    <th width="15%">Silo information</th>
                </tr></thead>
                <tbody>
                    {% for table in corp %}
                    {% if table is iterable %}
                        <tr>
                            <td>{{table.locationName }}</td>
                            <td>{{table.typeName}}</td>
                            <td>{{table.moonName}}</td>
                            <td>{{table.state}}</td>
                            <td>{{table.time.d}}d {{table.time.h}}h</td>
                            <td>
                                {% if table.stateID == 3 %}
                                    {{table.stateTimestamp}}
                                {% else %}
                                    {{table.rftime.d}}d {{table.rftime.h}}h
                                {% endif %}
                            </td>
                            <td>
                                {% if table.numSilo > 1 %}
                                <a class="btn btn-info" data-toggle="popover" title="Silos" data-content="
                                        {% for silo in table %}
                                        {% if silo.mmname is defined %}
                                        <b>{{silo.mmname}}</b>:<br>
                                        {{silo.quantity}}/{{silo.maximum}}<br>
                                        {% endif %}
                                        {% endfor %}">Show Silos</a>

                                {% else %}
                                    No Silo.
                                {% endif %}
                            </td>
                        </tr>
                    {% endif %}
                    {% endfor %}
                </tbody>
            </table>
        </div>
    {% endfor %}
{% else %}
    <div class="alert alert-danger" role="alert">Access denied. Autorization required.</div>
{% endif %}
{% endblock %}
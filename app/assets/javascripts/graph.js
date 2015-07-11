(function() {
    'use strict';
    if (riding !== undefined) {
        draw(riding);
    }

    function short_party_name(candidate) {
        return candidate.party_name.split(/[\s,\/,-]/)[0];
    }

    function add_names(data) {
        var names = data.candidates.map(short_party_name);
        var table = d3.select(".name_table");
        var row_num = 0;

        data.candidates.forEach(function (candidate) {
            var row = table.append("tr");
            row.append("td").text(candidate.party_name);
            row.append("td").text(candidate.name);
            row.append("td").text(candidate.votes);
        });
        return names;
    }

    function draw(data) {
        var bounds = {top: 450, right: 450, bottom: 50, left: 50};
        var graph = d3.select("#chart");
        var names = add_names(data);
        var max_votes = d3.max(data.candidates, function(candidate) {
            return candidate.votes
        });

        var y = d3.scale.linear()
            .range([bounds.top, bounds.bottom])
            .domain([0, max_votes]);

        var yAxis = d3.svg.axis()
            .scale(y)
            .orient("left");

        var x = d3.scale.ordinal()
            .domain(names)
            .rangeBands([bounds.left, bounds.right]);

        var xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom");

        graph.append("g")
            .attr("class", "y axis")
            .call(yAxis)
            .attr("transform", "translate(" + bounds.left + ", 0)");

        graph.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0, " + bounds.top + ")")
            .call(xAxis);

        graph.selectAll(".bar")
            .data(data.candidates)
            .enter().append("rect")
            .attr("class", "bar")
            .attr("x", function(candidate) { return x(short_party_name(candidate)); })
            .attr("class", function(candidate) { return short_party_name(candidate) + " party" })
            .attr("width", x.rangeBand())
            .attr("y", function(candidate) { return bounds.top - y(max_votes - candidate.votes) + bounds.bottom; })
            .attr("height", function(candidate) { return y(max_votes - candidate.votes) - bounds.bottom; });
    }

    function error() {
        var graph = d3.select("#chart");
        graph.append("text").text("Error " + window.riding_id);
        console.log("Error");
    }
})();
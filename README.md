# Advent of Code 2020

Solutions to [Advent of Code 2020 edition](https://adventofcode.com/2020) in Julia.

## Benchmarks

<html>
<meta charset="UTF-8">
<style>
  table, td, th {
      border-collapse: collapse;
      font-family: sans-serif;
  }

  td, th {
      border-bottom: 0;
      padding: 4px
  }

  tr:nth-child(odd) {
      background: #eee;
  }

  tr:nth-child(even) {
      background: #fff;
  }

  tr.header {
      background: navy !important;
      color: white;
      font-weight: bold;
  }

  tr.subheader {
      background: lightgray !important;
      color: black;
  }

  tr.headerLastRow {
      border-bottom: 2px solid black;
  }

  th.rowNumber, td.rowNumber {
      text-align: right;
  }

</style>
<body>
<table>
  <tr class = "header headerLastRow">
    <th style = "text-align: right; ">day</th>
    <th style = "text-align: right; ">part</th>
    <th style = "text-align: right; ">benchmark</th>
  </tr>
  <tr>
    <td style = "text-align: right; ">Day1</td>
    <td style = "text-align: right; ">part1</td>
    <td style = "color: green; font-weight: bold; text-align: right; ">Trial(33.922 μs)</td>
  </tr>
  <tr>
    <td style = "text-align: right; ">Day1</td>
    <td style = "text-align: right; ">part2</td>
    <td style = "text-align: right; ">Trial(165.170 μs)</td>
  </tr>
  <tr>
    <td style = "text-align: right; ">Day2</td>
    <td style = "text-align: right; ">part1</td>
    <td style = "color: red; font-weight: bold; text-align: right; ">Trial(1.272 ms)</td>
  </tr>
  <tr>
    <td style = "text-align: right; ">Day2</td>
    <td style = "text-align: right; ">part2</td>
    <td style = "color: red; font-weight: bold; text-align: right; ">Trial(1.024 ms)</td>
  </tr>
  <tr>
    <td style = "text-align: right; ">Day3</td>
    <td style = "text-align: right; ">part1</td>
    <td style = "color: green; font-weight: bold; text-align: right; ">Trial(51.712 μs)</td>
  </tr>
  <tr>
    <td style = "text-align: right; ">Day3</td>
    <td style = "text-align: right; ">part2</td>
    <td style = "text-align: right; ">Trial(117.770 μs)</td>
  </tr>
  <tr>
    <td style = "text-align: right; ">Day4</td>
    <td style = "text-align: right; ">part1</td>
    <td style = "color: red; font-weight: bold; text-align: right; ">Trial(1.510 ms)</td>
  </tr>
  <tr>
    <td style = "text-align: right; ">Day4</td>
    <td style = "text-align: right; ">part2</td>
    <td style = "color: red; font-weight: bold; text-align: right; ">Trial(3.029 ms)</td>
  </tr>
</table>
</body>
</html>


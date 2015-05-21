<html>
	<head>
		<title>Laravel</title>

		<link href='//fonts.googleapis.com/css?family=Raleway:400,100,300' rel='stylesheet' type='text/css'>
		<link href='{{ elixir("css/main.css") }}' rel='stylesheet' type='text/css'>
	</head>
	<body>
		<div class="container">
			<div class="content">
				<h1>Hello, Laravel 5</h1>
				<div class="quote">{{ Inspiring::quote() }}</div>
			</div>
		</div>

		<script src='{{ elixir("js/bundle.js") }}'></script>
	</body>
</html>

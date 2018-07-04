<html>
	<head>
		<title>PHP ба R</title>
	</head>
	<body>
		<form action="" method="get">
			<span>Санамсаргүй түүврийн хэмжээ</span>
			<input type="number" name="sample-size" min="1" max="1000" value="100">
			<button type="submit">Илгээх</button>
		</form>
<?php
	if (isset($_GET["sample-size"])) {
		$sample_size = intval($_GET["sample-size"]);
		$output = shell_exec("Rscript r-code.R $sample_size");
		$output = str_replace("\n", '<br />', $output);
		echo $output;
	}
?>
	</body>
</html>

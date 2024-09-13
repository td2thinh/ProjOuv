all: main experiment

main: 
	ocamlc -o main primitives.ml bigInt.ml utility.ml decisionTree.ml compression.ml dotFileGen.ml main.ml

experiment:
	ocamlc unix.cma -o experiment primitives.ml bigInt.ml utility.ml decisionTree.ml compression.ml dotFileGen.ml experiment.ml

runAll: all
	./main && ./experiment

runMain: main
	./main

runExperiment: experiment
	./experiment

png: 
	dot -Tpng resCompressionListe.dot -o resCompressionListe.png && dot -Tpng resCompressionArbre.dot -o resCompressionArbre.png && dot -Tpng resAvantCompression.dot -o resAvantCompression.png

clean:
	rm -f *.cmo *.cmi main experiment *.dot *.png *.csv
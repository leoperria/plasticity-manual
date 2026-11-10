.PHONY: all pdf check typ watch clean
all: pdf
pdf:
	python3 tools/build.py
check:
	python3 tools/check.py
typ:
	python3 tools/build.py --typ
watch:
	python3 tools/build.py --watch
clean:
	rm -rf build

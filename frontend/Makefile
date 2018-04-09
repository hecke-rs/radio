.PHONY: build watch serve

build:
	elm-make src/Main.elm --output app.js

watch:
	@while true; do \
		make build; \
		inotifywait -qre close_write src/; \
	done

serve:
	bash -c "trap 'kill 0' EXIT;\
	python3 -m http.server &\
	sass --watch style/main.scss:assets/main.css &\
	make watch"

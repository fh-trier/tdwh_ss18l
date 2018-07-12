# Docker Image
IMAGE := volkerraschek/docker-latex:latest

# Input tex-file and output pdf-file
FILE := index
TEX_NAME := ${FILE}.tex
PDF_NAME := ${FILE}.pdf

# Hardlink-Path and Hardlink-File
HARDLINK_PATH := ${HOME}/Dokumente/Studium/Fachschaftdaten/DWH_-_Data_Warehouse/Tutorien/Tutorium_SS18
HARDLINK_FILE := Tutorium_SS18.pdf

latexmk:
	latexmk \
		-shell-escape \
		-synctex=1 \
		-interaction=nonstopmode \
		-file-line-error \
		-pdf ${TEX_NAME}

pdflatex: makeglossar makeindex
	pdflatex \
		-shell-escape \
		-synctex=1 \
		-interaction=nonstopmode \
		-enable-write18 "${TEX_NAME}"

makeglossar:
	makeglossaries "${FILE}"

makeindex:
	makeindex "${FILE}.idx"

docker-latexmk:
	docker run \
		--rm \
		--user="$(shell id -u):$(shell id -g)" \
		--net="none" \
		--volume="${PWD}:/data" ${IMAGE} \
		make latexmk

docker-pdflatex:
	docker run \
		--rm \
		--user="$(shell id -u):$(shell id -g)" \
		--net="none" \
		--volume="${PWD}:/data" ${IMAGE} \
		make pdflatex

clean:
	git clean -fX

create-hardlink: delete-hardlink latexmk
	if [ ! -d ${HARDLINK_PATH} ]; \
	then \
		mkdir -p ${HARDLINK_PATH}; \
	fi;

	ln ${PWD}/${PDF_NAME} ${HARDLINK_PATH}/${HARDLINK_FILE}; \

delete-hardlink:
	if [ -f ${HARDLINK_PATH}/${HARDLINK_FILE} ]; \
	then \
		rm -R ${HARDLINK_PATH}/${HARDLINK_FILE}; \
	fi;

import:
	./import.sh

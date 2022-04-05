#curl -L https://get.pharo.org/64/alpha+vm | bash
# pharo 11 not ready
curl -L https://get.pharo.org/100+vm | bash
./pharo --headless Pharo.image ./scripts/visualizeClassDiagram.st

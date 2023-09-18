curl -L https://get.pharo.org/64/alpha+vm | bash
# curl -L https://get.pharo.org/100+vm | bash
./pharo --headless Pharo.image ./scripts/runCoverage.st

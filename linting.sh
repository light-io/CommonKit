if which swiftlint >/dev/null; then
  echo "Run linting"
  swiftlint --config "./.swiftlint.yml"
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi

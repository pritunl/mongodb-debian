VERSION=0.5.1

gpg --import ../../private_key.asc

mkdir -p /vagrant/depends/libyaml-cpp-dev/build
cd /vagrant/depends/libyaml-cpp-dev/build

wget http://archive.ubuntu.com/ubuntu/pool/universe/y/yaml-cpp/yaml-cpp_$VERSION.orig.tar.gz
tar xfz yaml-cpp_$VERSION.orig.tar.gz

cp -r ../debian ./yaml-cpp-$VERSION
cd yaml-cpp-$VERSION

sed -i -e 's/ubuntu1) unstable;/ubuntu1~precise) precise;/g' debian/changelog
debuild -S

cd ..

echo '\n\nRUN COMMANDS BELOW TO UPLOAD:'
echo 'sudo dput ppa:pritunl/pritunl-test ./build/yaml-cpp_'$VERSION'-0ubuntu1~precise_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-build ./build/yaml-cpp_'$VERSION'-0ubuntu1~precise_source.changes'

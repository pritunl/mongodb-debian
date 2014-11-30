VERSION=3.14.5.8

gpg --import ../../private_key.asc

mkdir -p /vagrant/depends/libv8/build
cd /vagrant/depends/libv8/build

wget http://archive.ubuntu.com/ubuntu/pool/universe/libv/libv8-3.14/libv8-3.14_$VERSION.orig.tar.gz
tar xfz libv8-3.14_$VERSION.orig.tar.gz

mv v8-* v8-$VERSION
cp -r ../debian ./v8-$VERSION
cd v8-$VERSION

sed -i -e 's/ubuntu2) unstable;/ubuntu2~precise) precise;/g' debian/changelog
debuild -S

cd ..

echo '\n\nRUN COMMANDS BELOW TO UPLOAD:'
echo 'sudo dput ppa:pritunl/pritunl-test ./build/libv8-3.14_'$VERSION'-5ubuntu2~precise_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-build ./build/libv8-3.14_'$VERSION'-5ubuntu2~precise_source.changes'

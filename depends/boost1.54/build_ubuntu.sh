VERSION=1.54.0

gpg --import ../../private_key.asc

mkdir -p /vagrant/depends/boost1.54/build
cd /vagrant/depends/boost1.54/build

wget http://archive.ubuntu.com/ubuntu/pool/main/b/boost1.54/boost1.54_$VERSION.orig.tar.bz2
tar xfj boost1.54_$VERSION.orig.tar.bz2

mv boost_1_54_0 boost1.54-$VERSION
cp -r ../debian ./boost1.54-$VERSION
cd boost1.54-$VERSION

sed -i -e 's/ubuntu3) unstable;/ubuntu3~precise) precise;/g' debian/changelog
debuild -S -sd

cd ..

echo '\n\nRUN COMMANDS BELOW TO UPLOAD:'
echo 'sudo dput ppa:pritunl/pritunl-test ./build/boost1.54_'$VERSION'-4ubuntu3~precise_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-build ./build/boost1.54_'$VERSION'-4ubuntu3~precise_source.changes'

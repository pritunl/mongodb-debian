VERSION=2.6.3

gpg --import private_key.asc

mkdir -p /vagrant/build
cd /vagrant/build

wget http://archive.ubuntu.com/ubuntu/pool/universe/m/mongodb/mongodb_$VERSION.orig.tar.gz
tar xfz mongodb_$VERSION.orig.tar.gz

mv mongodb-src-r$VERSION mongodb-$VERSION
rm -rf mongodb-$VERSION/debian
cp -r ../debian ./mongodb-$VERSION
cd mongodb-$VERSION

sed -i -e 's/ubuntu5) unstable;/ubuntu5~trusty) trusty;/g' debian/changelog
debuild -S -sd
sed -i -e 's/ubuntu5~trusty) trusty;/ubuntu5~precise) precise;/g' debian/changelog
debuild -S -sd

cd ..

echo '\n\nRUN COMMANDS BELOW TO UPLOAD:'
echo 'sudo dput ppa:pritunl/pritunl-test ./build/mongodb_'$VERSION'-0ubuntu5~trusty_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-test ./build/mongodb_'$VERSION'-0ubuntu5~precise_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-build ./build/mongodb_'$VERSION'-0ubuntu5~trusty_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-build ./build/mongodb_'$VERSION'-0ubuntu5~precise_source.changes'

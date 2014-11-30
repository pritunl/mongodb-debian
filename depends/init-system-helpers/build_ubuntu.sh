VERSION=1.14

gpg --import ../../private_key.asc

mkdir -p /vagrant/depends/init-system-helpers/build
cd /vagrant/depends/init-system-helpers/build

wget http://archive.ubuntu.com/ubuntu/pool/main/i/init-system-helpers/init-system-helpers_$VERSION.tar.gz
tar xfz init-system-helpers_$VERSION.tar.gz

mv init-system-helpers_$VERSION.tar.gz init-system-helpers_$VERSION.orig.tar.gz
rm -rf init-system-helpers-$VERSION/debian
cp -r ../debian ./init-system-helpers-$VERSION
cd init-system-helpers-$VERSION

sed -i -e 's/ubuntu1) unstable;/ubuntu1~precise) precise;/g' debian/changelog
debuild -S

cd ..

echo '\n\nRUN COMMANDS BELOW TO UPLOAD:'
echo 'sudo dput ppa:pritunl/pritunl-test ./build/init-system-helpers_'$VERSION'-0ubuntu1~precise_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-build ./build/init-system-helpers_'$VERSION'-0ubuntu1~precise_source.changes'

use inc::Module::Install;

name          ( 'Template-Plugin-Group'           );
abstract      ( 'Template plugin to group lists into simple subgroups' );
author        ( 'Adam Kennedy<cpan@ali.as>'         );
version_from  ( 'lib/Template/Plugin/Group.pm'    );
license       ( 'perl'                              );

requires      ( 'perl'                 => '5.005'   );
requires      ( 'Template'             => '2.10'    );

build_requires( 'Test::More'           => '0.47'    );
build_requires( 'File::Spec'           => '0.82'    );

auto_install();

&WriteAll;

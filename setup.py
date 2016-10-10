import setuptools

setuptools.setup(
    name='hello21',
    version='1.0.0',
    packages=setuptools.find_packages(),
    install_requires=[  # list all dependencies for your project here
        "Flask==0.10.1",  # required for hello21/server.py
        "PyYAML==3.11",  # required for scripts under hello21/utils
    ],
)

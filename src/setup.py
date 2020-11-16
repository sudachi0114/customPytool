import setuptools

if __name__ == "__main__":
    setuptools.setup(
        name="myapp",
        version="0.0.1",
        packages=setuptools.find_packages(),
        entry_points={
            "console_scripts":[
                "myapp = myapp.app:main",
            ],
        },
    )

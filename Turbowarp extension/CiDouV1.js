class StrictEqualityExtension {
    getInfo() {
      return {
        id: 'cidouv1', // id
        name: 'CiDou Block', //扩展名称 
        blocks: [
          {
            opcode: 'strictlyEquals',
            blockType: Scratch.BlockType.COMMAND, //类型
            text: 'Open[ONE]',
            arguments: {
              ONE: {
                type: Scratch.ArgumentType.STRING,
                defaultValue: 'https://www.kaka.city/'
              }
            }
          }
        ]
      };
    }
    strictlyEquals(args) {
      // Note strict equality: Inputs must match exactly: in type, case, etc.
      window.open(ONE);
    }
  }
  Scratch.extensions.register(new StrictEqualityExtension());

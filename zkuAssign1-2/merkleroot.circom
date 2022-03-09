pragma circom 2.0.3;
include "./mimcsponge.circom";
template merkleroot(n) {
    signal input leaves[n];
    signal nonLeaf[2];
    signal output root;

    component mimc1 = MiMCSponge(2,220,1);
    mimc1.ins[0] <== leaves[0];
    mimc1.ins[1] <== leaves[1];
    mimc1.k <== 0;

    nonLeaf[0] <== mimc1.outs[0];


    component mimc2 = MiMCSponge(2,220,1);
    mimc2.ins[0] <== leaves[2];
    mimc2.ins[1] <== leaves[3];
    mimc2.k <== 0;

    nonLeaf[1] <== mimc2.outs[0];


    component mimc3 = MiMCSponge(2,220,1);
    mimc3.ins[0] <== nonLeaf[0];
    mimc3.ins[1] <== nonLeaf[1];
    mimc3.k <== 0;

    root <== mimc3.outs[0];
}

component main {public[leaves]} = merkleroot(4);
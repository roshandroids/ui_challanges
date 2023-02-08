import 'package:flutter/material.dart';
import '../instagram_ui.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _tabIcons = [
    Icons.grid_on_rounded,
    Icons.person_3_outlined,
  ];
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataModel = InstagramDataModel.fromMap(instagramFakeData);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.chevron_left,
            size: 40,
          ),
        ),
        leadingWidth: 20,
        title: Row(
          children: [
            const Icon(
              Icons.lock,
              size: 15,
            ),
            Text(dataModel.profile.username),
            const Icon(
              Icons.expand_more_rounded,
              size: 15,
            ),
          ],
        ),
        actions: const [
          Icon(Icons.add_box_outlined),
          SizedBox(width: 15),
          Icon(Icons.menu),
          SizedBox(width: 5),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.4,
                            color: Colors.white.withOpacity(.4),
                          ),
                          color: Theme.of(context).dividerColor),
                      padding: const EdgeInsets.all(3),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(dataModel.profile.image),
                      ),
                    ),
                    InfoWidget(
                      label: 'Posts',
                      value: '${dataModel.profile.postCount}',
                    ),
                    InfoWidget(
                      label: 'Followers',
                      value: '${dataModel.profile.followerCount}',
                    ),
                    InfoWidget(
                      label: 'Following',
                      value: '${dataModel.profile.followingCount}',
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    dataModel.profile.profileName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    dataModel.profile.bio,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    dataModel.profile.website,
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2.4,
                      margin: const EdgeInsets.only(left: 8, top: 2),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.27),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Text(
                        'Edit profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2.4,
                      margin: const EdgeInsets.only(left: 8, top: 2),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.27),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Text(
                        'Share profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 8, top: 2),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 2),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.27),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Icon(
                        Icons.person_add_alt_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemExtent: 90,
                    itemCount: dataModel.highlights.length,
                    itemBuilder: (context, index) {
                      final item = dataModel.highlights[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  HighlightsView(highlights: item),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1.4,
                                        color: Colors.white.withOpacity(.4))),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(item.image),
                                ),
                              ),
                              Text(
                                item.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverAppBar(
            pinned: true,
            flexibleSpace:
                const FlexibleSpaceBar(collapseMode: CollapseMode.pin),
            backgroundColor: Colors.black,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                tabs: _tabIcons
                    .map((e) => Tab(
                          icon: Icon(e),
                        ))
                    .toList(),
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: _tabIcons.map((e) {
                final postList = [
                  ...dataModel.userPost,
                  ...dataModel.userPost,
                  ...dataModel.userPost,
                  ...dataModel.userPost,
                ]..shuffle();
                return GridView.builder(
                    itemCount: postList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 3,
                    ),
                    itemBuilder: (context, index) {
                      final item = postList[index];
                      return SizedBox(
                        height: 100,
                        child: Stack(
                          children: [
                            Image.network(
                              item,
                              fit: BoxFit.cover,
                            ),
                            const Positioned(
                              right: 0,
                              top: 0,
                              child: Icon(
                                Icons.layers,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                    });
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        Text(
          label,
          style:
              const TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ],
    );
  }
}
